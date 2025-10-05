class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name_es
      t.string :name_en
      t.string :name_br
      t.boolean :active

      t.timestamps
    end
  end
end
