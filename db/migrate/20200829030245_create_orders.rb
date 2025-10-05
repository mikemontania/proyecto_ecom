class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.string :tax_number
      t.string :tax_name
      t.integer :total
      t.integer :user_id
      t.boolean :canceled
      t.boolean :paid
      t.integer :payment_transaction_id
      t.datetime :payment_date
      t.string :shipping_phone
      t.string :shipping_address
      t.string :shipping_observation
      t.string :shipping_department
      t.string :shipping_city
      t.string :shipping_neighborhood
      t.string :billing_address
      t.string :billing_phone
      t.string :billing_observation
      t.string :billing_department
      t.string :billing_city
      t.string :billing_neighborhood

      t.timestamps
    end
  end
end
