class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.references :shopping_cart, null: false, foreign_key: true
      t.references :internal_product, null: false, foreign_key: true
      t.decimal :quantity, default: 1
      t.decimal :unit_price
      t.decimal :gross_total
      t.decimal :discount_rate, default: 0
      t.decimal :discount_amount, default: 0
      t.decimal :net_total

      t.timestamps
    end
  end
end
