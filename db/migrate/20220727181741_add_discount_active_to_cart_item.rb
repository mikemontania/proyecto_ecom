class AddDiscountActiveToCartItem < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :discount_active, :boolean, default: false
  end
end
