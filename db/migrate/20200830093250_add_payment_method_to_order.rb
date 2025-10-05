class AddPaymentMethodToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :payment_method, null: false, foreign_key: true
  end
end
