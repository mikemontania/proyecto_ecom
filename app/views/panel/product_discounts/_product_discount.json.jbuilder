json.extract! product_discount, :id, :internal_product_id, :min_quantity, :max_quantity, :discount_rate, :begin_date, :end_date, :created_at, :updated_at
json.url product_discount_url(product_discount, format: :json)
