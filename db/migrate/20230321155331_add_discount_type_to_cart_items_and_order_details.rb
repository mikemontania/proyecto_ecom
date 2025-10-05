class AddDiscountTypeToCartItemsAndOrderDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :discount_type, :string
    add_column :order_details, :discount_type, :string
  end
end
