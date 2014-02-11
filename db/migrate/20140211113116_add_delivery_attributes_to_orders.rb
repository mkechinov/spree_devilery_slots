class AddDeliveryAttributesToOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :delivery_date, :date
    add_column :spree_orders, :delivery_slot_id, :integer
    add_column :spree_orders, :delivery_instructions, :text
  end
end
