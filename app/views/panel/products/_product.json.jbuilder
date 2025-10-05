json.extract! product, :id, :name_es, :name_en, :name_br, :description_es, :description_en, :description_br, :uses_es, :uses_en, :uses_br, :active, :featured, :category_id, :subcategory_id, :created_at, :updated_at
json.url product_url(product, format: :json)
