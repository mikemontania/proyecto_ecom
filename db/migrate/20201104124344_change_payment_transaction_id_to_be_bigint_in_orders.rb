class ChangePaymentTransactionIdToBeBigintInOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :payment_transaction_id, :bigint
  end
end
