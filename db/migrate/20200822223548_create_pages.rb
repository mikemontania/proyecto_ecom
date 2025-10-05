class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title_es
      t.string :title_en
      t.string :title_br
      t.text :content_es
      t.text :content_en
      t.text :content_br
      t.string :icon
      t.integer :order
      t.boolean :active

      t.timestamps
    end
  end
end
