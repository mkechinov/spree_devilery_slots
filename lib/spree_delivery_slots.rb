require 'spree_core'
require 'spree_delivery_slots/engine'

module SpreeDeliverySlots
  class << self
    def available_for(from, to = nil)
      to = from if to.blank?

      results = []

      (from..to).each do |date|
        results += filtered_slots_at(date)
      end

      results
    end

    def filtered_slots_at(date)
      slots = Spree::DeliverySlot.available_at(date)
      exceptions = Spree::DeliveryException.excepted_slots_for_date(date)

      slots - exceptions
    end
  end
end
