class RemoveTotalFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :total, :decimal
  end
end
