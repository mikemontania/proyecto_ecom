class RemoveLocationFromBranches < ActiveRecord::Migration[6.0]
  def change
    remove_column :branches, :location, :string
  end
end
