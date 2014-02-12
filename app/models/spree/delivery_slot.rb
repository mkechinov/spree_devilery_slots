module Spree
  class DeliverySlot < ActiveRecord::Base
    has_many :delivery_exceptions, dependent: :destroy
    has_many :orders

    validates :name, presence: true, length: { in: 1..250 }
    validates :enabled, presence: true
    validates :start_hour, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 24, greater_than_or_equal_to: 0 }
    validates :days, presence: true
    validates :max_orders, numericality: { only_integer: true }
    validates :sequence, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :delay, presence: true, numericality: { only_integer: true }

    default_scope -> { order('sequence asc') }

    def full_name
      "#{name} (#{days})"
    end

    class << self
      def for_date(date)
        where('days LIKE ?', "%#{Date::DAYNAMES[date.wday]}%").where('delay < ?', 24 - Time.current.hour)
      end

      def next_sequence
        if max = unscoped.order('sequence desc').pluck(:sequence).first
          max + 1
        else
          1
        end
      end
    end
  end
end
