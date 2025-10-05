class CreateCountdowns < ActiveRecord::Migration[6.0]
  def change
    create_table :countdowns do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :link, null: true, default: ""
      t.boolean :active, default: false

      t.timestamps
    end
  end
end

