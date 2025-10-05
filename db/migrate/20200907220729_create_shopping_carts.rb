class CreateShoppingCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_carts do |t|
      t.references :user, null: true, foreign_key: true
      t.uuid :session_uuid, null: false, default: 'uuid_generate_v4()'
      t.boolean :abandoned, default: false
      t.datetime :last_operation, default: Time.now

      t.timestamps
    end
  end
end
