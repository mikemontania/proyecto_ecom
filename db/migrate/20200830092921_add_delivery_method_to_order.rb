class AddDeliveryMethodToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :delivery_method, null: false, foreign_key: true
    add_column :orders, :carry_out, :boolean
  end
end
