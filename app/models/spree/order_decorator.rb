Spree::Order.class_eval do
  belongs_to :delivery_slot

  require 'date'
  require 'spree/order/checkout'

  def valid_delivery_instructions?
    if self.delivery_instructions.length > 500
      self.errors[:delivery_instructions] << 'cannot be longer than 500 characters'
      return false
    end
    true
  end

  def valid_delivery_date?
    self.errors[:delivery_date] << 'cannot be blank' unless self.delivery_date

    self.errors[:delivery_date].empty?
  end

  def valid_delivery_slot?
    self.errors[:delivery_slot] << 'cannot be blank' unless self.delivery_slot

    self.errors[:delivery_slot].empty?
  end

  def valid_delivery_slot_full?
    unless self.delivery_slot.available?(self.delivery_date)
      self.errors[:delivery_slot] << 'not available' if self.delivery_slot.full?(self.delivery_date)
    end

    self.errors[:delivery_slot].empty?
  end

  def delivery_price
    delivery_slot ? delivery_slot.total_price(delivery_date) : 0
  end
end

Spree::PermittedAttributes.checkout_attributes << :delivery_date
Spree::PermittedAttributes.checkout_attributes << :delivery_slot_id
Spree::PermittedAttributes.checkout_attributes << :delivery_instructions

#Spree::Order.state_machine.before_transition :to => :address, :do => :valid_delivery_instructions?
#Spree::Order.state_machine.before_transition :to => :address, :do => :valid_delivery_date?
#Spree::Order.state_machine.before_transition :to => :address, :do => :valid_delivery_slot?
#Spree::Order.state_machine.before_transition :to => :address, :do => :valid_delivery_slot_full?

Spree::Order.state_machine.before_transition :to => :payment, :do => :valid_delivery_instructions?
Spree::Order.state_machine.before_transition :to => :payment, :do => :valid_delivery_date?
Spree::Order.state_machine.before_transition :to => :payment, :do => :valid_delivery_slot?
Spree::Order.state_machine.before_transition :to => :payment, :do => :valid_delivery_slot_full?
Spree::Order.state_machine.before_transition :to => :payment, :do => :create_proposed_shipments
