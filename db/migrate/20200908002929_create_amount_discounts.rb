class CreateAmountDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :amount_discounts do |t|
      t.decimal :min_amount
      t.decimal :max_amount
      t.decimal :discount_rate
      t.date :begin_date
      t.date :end_date

      t.timestamps
    end
  end
end
