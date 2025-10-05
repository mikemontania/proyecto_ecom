class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.string :name_es
      t.string :name_en
      t.string :name_br
      t.string :address
      t.string :image
      t.string :phone
      t.string :hours
      t.string :location
      t.boolean :active

      t.timestamps
    end
  end
end
