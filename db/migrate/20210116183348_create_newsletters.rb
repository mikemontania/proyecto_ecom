class CreateNewsletters < ActiveRecord::Migration[6.0]
  def change
    create_table :newsletters do |t|
      t.string :name
      t.string :email, unique: true

      t.timestamps
    end
  end
end
