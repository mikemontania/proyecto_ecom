class AddFieldToCartItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cart_items, :is_discount_import, :boolean, default: false
  end
end
