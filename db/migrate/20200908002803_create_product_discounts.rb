class CreateProductDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :product_discounts do |t|
      t.references :internal_product, null: false, foreign_key: true
      t.integer :min_quantity
      t.integer :max_quantity
      t.decimal :discount_rate
      t.date :begin_date
      t.date :end_date

      t.timestamps
    end
  end
end
