class AddNewFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :id_type, :string
    add_column :users, :id_number, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :subscribed, :boolean
  end
end
