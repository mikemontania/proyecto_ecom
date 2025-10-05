class AddInternalNameToPaymentMethods < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_methods, :internal_name, :string
  end
end
