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
      self.expires_at = 1.hours.from_now
    end

    def expired?
      self.expires_at < Time.now
    end

    def self.clean_expired
      self.expired.destroy_all
    end

    def self.get_current
      if spree_current_user && spree_current_user.delivery_slot_reservation && spree_current_user.delivery_slot_reservation.expired? == false
        return spree_current_user.delivery_slot_reservation
      end

      if session && session[:session_id]
        return self.active.where(user_session: session[:session_id]).last
      end

      nil
    end

    def self.destroy_current
        spree_current_user.delivery_slot_reservation.destroy       if spree_current_user && spree_current_user.delivery_slot_reservation
        self.where(user_session: session[:session_id]).destroy_all if session && session[:session_id]
    end
  end
end
