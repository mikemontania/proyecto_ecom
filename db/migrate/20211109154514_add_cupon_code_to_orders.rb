class AddCuponCodeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :coupon_code, :string, null: true
    add_column :orders, :coupon_discount, :integer, null: true, default: 0
    add_column :orders, :coupon_used, :boolean, default: false
  end
end
