class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.references :user, null: false, foreign_key: true
      t.string :coupon_code
      t.date :expiration_date
      t.integer :discount
      t.string :qr_link
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
