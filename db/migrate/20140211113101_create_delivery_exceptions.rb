class CreateDeliveryExceptions < ActiveRecord::Migration
  def change
    create_table :spree_delivery_exceptions do |t|
      t.references :delivery_slot
      t.date :date
    end
  end
end
