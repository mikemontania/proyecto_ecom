class CreateSliders < ActiveRecord::Migration[6.0]
  def change
    create_table :sliders do |t|
      t.string :name
      t.string :link
      t.boolean :active
      t.integer :order

      t.timestamps
    end
  end
end
