class CreateVarieties < ActiveRecord::Migration[6.0]
  def change
    create_table :varieties do |t|
      t.string :name_es
      t.string :name_en
      t.string :name_br
      t.boolean :active
      t.string :icon

      t.timestamps
    end
  end
end
