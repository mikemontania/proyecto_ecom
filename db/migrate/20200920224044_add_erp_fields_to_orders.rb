class AddErpFieldsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :erp_status, :integer, default: 0
    add_column :orders, :erp_error, :boolean, default: false
    add_column :orders, :erp_message, :string
  end
end
