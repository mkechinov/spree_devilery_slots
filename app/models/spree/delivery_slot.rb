module Spree
  class DeliverySlot < ActiveRecord::Base
    has_many :delivery_exceptions
    has_many :orders

    validates :name, presence: true, length: { in: 1..250 }
    validates :days, presence: true
    validates :max_orders, numericality: { only_integer: true }
    validates :sequence, presence: true, numericality: { only_integer: true }
    validates :delay, presence: true, numericality: { only_integer: true }
  end
end
