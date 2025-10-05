class RemoveImageColumnsFromModels < ActiveRecord::Migration[6.0]
  def change
    remove_column :presentations, :icon, :string
    remove_column :branches, :image, :string
    remove_column :internal_products, :image, :string
    remove_column :pages, :icon, :string
  end
end
