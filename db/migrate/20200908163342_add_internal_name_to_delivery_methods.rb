class AddInternalNameToDeliveryMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_methods, :internal_name, :string
  end
end
