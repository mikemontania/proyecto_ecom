class CreateDeliveryMethods < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_methods do |t|
      t.string :name
      t.boolean :active
      t.boolean :carry_out
      t.timestamps
    end
  end
end
