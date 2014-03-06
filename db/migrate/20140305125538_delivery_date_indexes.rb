class DeliveryDateIndexes < ActiveRecord::Migration
  def change
    add_index :spree_orders, :delivery_date
    add_index :spree_delivery_slot_reservations, :delivery_date
  end
end
