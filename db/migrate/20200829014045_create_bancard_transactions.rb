class CreateBancardTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :bancard_transactions do |t|
      t.date :transaction_date
      t.time :transaction_time
      t.integer :transaction_status, default: 0
      t.string :shop_process_id
      t.string :process_id
      t.decimal :total_amount, precision: 12, scale: 2
      t.string :currency
      t.string :description
      t.string :token
      t.string :api_url
      t.string :return_url
      t.string :cancel_url
      t.string :response
      t.string :response_details
      t.bigint :auth_number
      t.bigint :ticket_number
      t.string :response_code
      t.string :response_description
      t.string :extended_description
      t.string :customer_ip
      t.string :card_country
      t.integer :risk_index
      t.timestamps
    end
  end
end
