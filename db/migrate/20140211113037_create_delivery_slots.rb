class CreateDeliverySlots < ActiveRecord::Migration
  def change
    create_table :spree_delivery_slots do |t|
      t.string :name, null: false
      t.string :days, null: false
      t.boolean :enabled, default: true, null: :false
      t.integer :start_hour, null: false
      t.integer :delay, null: false
      t.integer :max_orders, null: false
      t.integer :sequence
    end
  end
end
