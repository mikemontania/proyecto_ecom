class AddIframeToBranches < ActiveRecord::Migration[6.0]
  def change
    add_column :branches, :iframe, :string
  end
end
