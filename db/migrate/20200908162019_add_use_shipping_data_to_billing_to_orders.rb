class AddUseShippingDataToBillingToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :use_shipping_data_to_billing, :boolean
  end
end
