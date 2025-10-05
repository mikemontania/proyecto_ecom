class AddMailSentToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :mail_sent_at, :datetime
  end
end
