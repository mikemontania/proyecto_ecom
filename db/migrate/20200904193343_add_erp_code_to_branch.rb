class AddErpCodeToBranch < ActiveRecord::Migration[6.0]
  def change
    add_column :branches, :erp_code, :string
  end
end
