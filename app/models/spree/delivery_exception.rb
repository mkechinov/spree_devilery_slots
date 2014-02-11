module Spree
  class DeliveryException < ActiveRecord::Base
    belongs_to :delivery_slot

    validates :delivery_slot, presence: true
    validates :date, presence: true
  end
end
