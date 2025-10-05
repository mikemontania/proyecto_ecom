class AddProductNameToProductDiscounts < ActiveRecord::Migration[6.0]
  def change
    add_column :product_discounts, :product_name, :string
  end
end
