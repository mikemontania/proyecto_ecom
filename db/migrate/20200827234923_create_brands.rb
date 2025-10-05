class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :active
      t.integer :order

      t.timestamps
    end
  end
end
