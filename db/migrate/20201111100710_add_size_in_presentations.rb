class AddSizeInPresentations < ActiveRecord::Migration[6.0]
  def change
    add_column :presentations, :size, :integer
  end
end
