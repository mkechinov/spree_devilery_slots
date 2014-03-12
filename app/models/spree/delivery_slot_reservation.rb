module Spree
  class DeliverySlotReservation < ActiveRecord::Base
    belongs_to :user
    belongs_to :delivery_slot

    validates :delivery_date, presence: true
    validates :expires_at,    presence: true
    validates :delivery_slot, presence: true

    after_initialize :after_initialize

    scope :expired, -> { where('expires_at < ?',  Time.now) }
    scope :active,  -> { where('expires_at >= ?', Time.now) }

    def after_initialize
      self.expires_at ||= 1.hours.from_now
    end

    def expired?
      self.expires_at < Time.now
    end

    def self.clean_expired
      self.expired.destroy_all
    end

    def self.current(user, session_id)
      if user && user.delivery_slot_reservation && user.delivery_slot_reservation.expired? == false
        return user.delivery_slot_reservation
      end

      if session_id
        return self.active.where(user_session: session_id).last
      end

      nil
    end

    def self.destroy_current(user, session_id)
      user.delivery_slot_reservation.destroy if user && user.delivery_slot_reservation
      self.where(user_session: session_id).destroy_all if session_id
    end
  end
end
