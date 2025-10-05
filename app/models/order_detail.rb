class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :internal_product
end
