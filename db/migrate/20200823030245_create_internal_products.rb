class CreateInternalProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :internal_products do |t|
      t.references :product, null: false, foreign_key: true
      t.string :internal_code
      t.decimal :price
      t.boolean :active
      t.boolean :featured
      t.references :presentation, null: false, foreign_key: true
      t.references :variety, null: false, foreign_key: true
      t.boolean :main
      t.string :image

      t.timestamps
    end
  end
end
