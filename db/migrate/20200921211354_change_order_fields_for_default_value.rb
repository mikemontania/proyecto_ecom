class ChangeOrderFieldsForDefaultValue < ActiveRecord::Migration[6.0]
  def up
    change_column :orders, :shipping_neighborhood, :string, null: true, default: ''
  end

  def down
    change_column :orders, :shipping_neighborhood, :string, null: false
  end
end
