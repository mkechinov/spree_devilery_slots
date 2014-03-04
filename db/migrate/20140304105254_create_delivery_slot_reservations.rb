class CreateDeliverySlotReservations < ActiveRecord::Migration
  def change
    create_table :spree_delivery_slot_reservations do |t|
      t.integer  :user_id, null: false
      t.integer  :delivery_slot_id, null: false
      t.datetime :expires_at
    end
  end
end
