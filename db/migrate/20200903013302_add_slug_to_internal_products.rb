class AddSlugToInternalProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :internal_products, :slug, :string
    add_index :internal_products, :slug, unique: true
  end
end
