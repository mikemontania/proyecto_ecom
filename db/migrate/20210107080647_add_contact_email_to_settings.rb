class AddContactEmailToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :contact_email, :string
  end
end
