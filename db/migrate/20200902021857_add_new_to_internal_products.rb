class AddNewToInternalProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :internal_products, :is_new, :boolean
  end
end
