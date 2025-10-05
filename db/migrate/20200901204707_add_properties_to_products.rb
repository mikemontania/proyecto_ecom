class AddPropertiesToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :properties_es, :text
    add_column :products, :properties_en, :text
    add_column :products, :properties_br, :text
  end
end
