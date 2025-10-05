class AddDeliveryPaymentMethodToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :delivery_payment_method, :string
  end
end
