class AddCoupocodeToUserTable < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coupon_code, :string
    add_column :users, :coupon_used, :boolean, default: false
  end
end
