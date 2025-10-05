class ProductDiscount < ApplicationRecord
  belongs_to :internal_product

  def product_name
    "#{internal_product.product.name} #{internal_product.variety.name} #{internal_product.presentation.name}"
  end

end
