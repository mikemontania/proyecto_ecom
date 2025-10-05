class AddBankTransferReferenceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :bank_transfer_reference, :string
  end
end
