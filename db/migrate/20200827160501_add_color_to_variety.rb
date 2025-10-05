class AddColorToVariety < ActiveRecord::Migration[6.0]
  def change
    add_column :varieties, :color, :string
  end
end
