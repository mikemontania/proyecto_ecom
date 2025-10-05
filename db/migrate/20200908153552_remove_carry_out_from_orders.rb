class RemoveCarryOutFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :carry_out, :boolean
  end
end
