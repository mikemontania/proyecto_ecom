class AddOrderToBancardTransaction < ActiveRecord::Migration[6.0]
  def change
    add_reference :bancard_transactions, :order, null: true, foreign_key: true
  end
end
