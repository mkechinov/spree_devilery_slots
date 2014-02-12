module Spree
  class DeliveryException < ActiveRecord::Base
    belongs_to :delivery_slot

    validates :delivery_slot, presence: true
    validates :date, presence: true

    class << self
      def excepted_slots_for_date(date)
        where(date: date).pluck(:delivery_slot_id)
      end
    end
  end
end
