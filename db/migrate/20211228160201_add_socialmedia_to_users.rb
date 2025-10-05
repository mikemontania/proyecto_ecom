class AddSocialmediaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :new_sm, :boolean, default: false
    add_column :users, :from_sm, :boolean, default: false
  end
end
