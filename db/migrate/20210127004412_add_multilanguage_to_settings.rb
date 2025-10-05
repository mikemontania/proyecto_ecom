class AddMultilanguageToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :multilanguage, :boolean
  end
end
