class RemoveIconFromVarieties < ActiveRecord::Migration[6.0]
  def change
    remove_column :varieties, :icon, :string
  end
end
