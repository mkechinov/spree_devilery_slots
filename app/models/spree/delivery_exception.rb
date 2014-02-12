module Spree
  class DeliveryException < ActiveRecord::Base
    belongs_to :delivery_slot

    validates :delivery_slot, presence: true
    validates :date, presence: true

    class << self
      def excepted_slots_for_date(date)
        where(date: date).includes(:delivery_slot).map(&:delivery_slot)
      end
    end
  end
end
