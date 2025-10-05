class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.decimal :minimum_purchase
      t.boolean :send_orders_to_service

      t.timestamps
    end
  end
end
