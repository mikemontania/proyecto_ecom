class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :qr_link, :string
    add_column :users, :new_user, :boolean, default: false
  end
end
