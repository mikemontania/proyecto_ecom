class CartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :internal_product

  def calculate_totals
    current_date_string = Time.now.strftime('%Y-%m-%d')

    product_discount = ProductDiscount.where(internal_product_id: internal_product.id)
                .where('min_quantity <= ? AND max_quantity >= ?', quantity, quantity)
                .where('begin_date <= ? AND end_date >= ?', current_date_string, current_date_string)
                .first

    changed = false

    if product_discount.present?
      if self.discount_rate == product_discount.discount_rate  # Chequear si el % del descuento cambió.
        if self.discount_active == false
          changed = true
        end

      elsif self.discount_rate != product_discount.discount_rate
        changed = true
      end

      if self.unit_price.to_i != internal_product.price.to_i # Chequear en caso de que el precio del producto cambie durante una promoción.
        changed = true
      end

      self.unit_price = internal_product.price
      self.gross_total = self.unit_price * self.quantity
      self.discount_active = true
      self.is_discount_import = false
      self.discount_type = "producto"
      self.discount_rate = product_discount.discount_rate
      self.discount_amount = product_discount.discount_rate == 0 ? 0 : ((self.gross_total * self.discount_rate) / 100).round
      self.net_total = product_discount.discount_rate == 0 ? self.gross_total : self.gross_total - self.discount_amount
      self.save
    else

      # DESCUENTO POR IMPORTE
      gross_calculate_total = self.unit_price * self.quantity

      get_amount_discount = AmountDiscount
        .where('min_amount <= ? and max_amount >= ?', gross_calculate_total, gross_calculate_total)
        .first

      if get_amount_discount.present?
        Rails.logger.debug(get_amount_discount.inspect)

        if self.discount_active # Chequear primero si el producto estuvo en una promoción.
          changed = true
        end

        if self.unit_price.to_i != internal_product.price.to_i # Chequear si el producto cambió de precio fuera de una promoción.
          changed = true
        end

        Rails.logger.debug("El monto entró a un descuento por monto: #{get_amount_discount.inspect}")
        self.unit_price = internal_product.price
        self.gross_total = self.unit_price * self.quantity
        self.discount_active = false
        self.is_discount_import = true
        self.discount_type = "escala"
        self.discount_rate = 0 #get_amount_discount.discount_rate
        self.discount_amount = 0 #((self.gross_total * self.discount_rate) / 100).round
        self.net_total = self.gross_total - self.discount_amount
        self.save
      else

        if self.discount_active # Chequear primero si el producto estuvo en una promoción.
          changed = true
        end

        if self.unit_price.to_i != internal_product.price.to_i # Chequear si el producto cambió de precio fuera de una promoción.
          changed = true
        end

        self.unit_price = internal_product.price
        self.gross_total = self.unit_price * self.quantity
        self.discount_active = false
        self.is_discount_import = false
        self.discount_type = "escala"
        self.discount_rate = 0
        self.discount_amount = 0
        self.net_total = self.gross_total - self.discount_amount
        self.save
      end
    end

    return changed
  end

  def calculate_coupon_totals
    self.unit_price = internal_product.price
    self.gross_total = unit_price * quantity
    self.discount_rate = product_discount.present? ? product_discount.discount_rate : 0
    self.discount_amount = product_discount.present? ? ((gross_total * discount_rate) / 100).round : 0
    self.net_total = gross_total - discount_amount
  end
end
