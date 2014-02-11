class CreateDeliveryExceptions < ActiveRecord::Migration
  def change
    create_table :spree_delivery_exceptions do |t|
      t.references :delivery_slot_id
      t.date :date
    end
  end
end
