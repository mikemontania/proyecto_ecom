class AddErpSentAtToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :erp_sent_at, :datetime
  end
end
