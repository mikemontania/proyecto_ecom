class ChangeCheckFieldsToOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :use_shipping_data_to_billing, :boolean
    add_column :orders, :use_different_billing_address, :boolean
  end
end
