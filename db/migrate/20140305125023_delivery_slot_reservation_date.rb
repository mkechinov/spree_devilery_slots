class DeliverySlotReservationDate < ActiveRecord::Migration
  def change
    add_column :spree_delivery_slot_reservations, :delivery_date, :date, null: false
  end
end
