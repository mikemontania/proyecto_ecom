class AddTaxDocumentTypeToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :tax_number_type, :string
  end
end
