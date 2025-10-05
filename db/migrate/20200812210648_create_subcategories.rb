class CreateSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :subcategories do |t|
      t.string :name_es
      t.string :name_en
      t.string :name_br
      t.boolean :active
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
