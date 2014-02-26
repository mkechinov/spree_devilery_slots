module Spree
  class DeliveryCity < ActiveRecord::Base
    has_many :delivery_slots

    validates :name, presence: true, length: { in: 1..250 }
  end
end
