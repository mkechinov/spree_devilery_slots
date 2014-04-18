module Spree
  class DeliverySlot < ActiveRecord::Base
    has_many :delivery_exceptions, dependent: :destroy
    has_many :orders
    has_many :reservations, class_name: 'Spree::DeliverySlotReservation'
    belongs_to :delivery_city

    validates :name, presence: true, length: { in: 1..250 }
    #validates :enabled, presence: true
    validates :start_hour, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 24, greater_than_or_equal_to: 0 }
    validates :days, presence: true
    validates :max_orders, numericality: { only_integer: true }
    validates :sequence, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :delay, presence: true, numericality: { only_integer: true }
    validates :delivery_city_id, presence: true
    validates :price_next_day, :price_same_day, :discount_price, presence: true, numericality: true

    default_scope -> { order('sequence asc') }

    def full_name
      "#{name} (#{days})"
    end

    def city_name
      delivery_city.name
    end

    def discounted?(date)
      discount_days.to_s.include?(Date::DAYNAMES[date.wday])
    end

    def reserved?(user, session_id, date)
      r = DeliverySlotReservation.current user, session_id

      r && r.delivery_date == date && r.delivery_slot_id == self.id
    end

    def available_to_user?(user, session_id, date)
      reserved?(user, session_id, date) || available?(date)
    end

    def available?(date)
      not_exception?(date) && delivered?(date) && time_not_ended?(date) && not_full?(date)
    end

    def slot_time(date)
      Time.at(date.to_time.to_i + start_hour * 3600)
    end

    def not_exception?(date)
      delivery_exceptions.where(date: date).empty?
    end

    def delivered?(date)
      days.to_s.include?(Date::DAYNAMES[date.wday])
    end

    def time_not_ended?(date)
      (slot_time(date) - Time.current).round > (delay * 3600)
    end

    def full?(date)
      !not_full?(date)
    end

    def not_full?(date)
      orders.where(delivery_date: date).count + reservations.where(delivery_date: date).count < max_orders
    end

    def selected_for?(date, order)
      orders.where(delivery_date: date).include? order
    end

    def total_price(delivery_date, order_date = Date.current)
      if order_date == delivery_date
        price_same_day
      elsif discounted?(delivery_date)
        discount_price
      else
        price_next_day
      end
    end

    class << self
      def available_at(date)
        res = where('days LIKE ?', "%#{Date::DAYNAMES[date.wday]}%").select do |slot|
          slot_time = Time.at(date.to_time.to_i + slot.start_hour * 3600)

          (slot_time - Time.current).round > (slot.delay * 3600)
        end

        res.select do |slot|
          slot.orders.where(delivery_date: date).count < slot.max_orders
        end
      end

      def next_sequence
        max = unscoped.order('sequence desc').pluck(:sequence).first

        if max
          max + 1
        else
          1
        end
      end

    end
  end
end
