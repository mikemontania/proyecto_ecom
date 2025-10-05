class CreateRepresentatives < ActiveRecord::Migration[6.0]
  def change
    create_table :representatives do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :website
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
