class UserFields < ActiveRecord::Migration
  def change
    add_column    :spree_delivery_slot_reservations, :user_session, :string
    change_column :spree_delivery_slot_reservations, :user_id,      :integer, null: true
  end
end
