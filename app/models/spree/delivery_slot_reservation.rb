module Spree
  class DeliverySlotReservation < ActiveRecord::Base
    belongs_to :user
    belongs_to :delivery_slot

    scope :expired, -> { where('expires_at < ?',  Time.now) }
    scope :active,  -> { where('expires_at >= ?', Time.now) }

    def initialize
      self.expires_at = 1.hours.from_now
    end

    def expired?
      self.expires_at < Time.now
    end

    def self.clean_expired
      self.expired.destroy_all
    end
  end
end
