require 'spree_core'
require 'spree_delivery_slots/engine'

module SpreeDeliverySlots
  class << self
    def for(date)
      res = Spree::DeliverySlot.for_date(date)

      exceptions = Spree::DeliveryException.excepted_slots_for_date(date)
      res = res.where.not(id: exceptions) if exceptions.any?

      res
    end
  end
end
