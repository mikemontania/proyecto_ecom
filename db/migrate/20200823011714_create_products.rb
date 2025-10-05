class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name_es
      t.string :name_en
      t.string :name_br
      t.text :description_es
      t.text :description_en
      t.text :description_br
      t.text :uses_es
      t.text :uses_en
      t.text :uses_br
      t.boolean :active
      t.boolean :featured
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
