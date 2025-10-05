class ShoppingCart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :internal_products, through: :cart_items

  def add_item(object, add_quantity = 1)
    item = find_item(object)
    if item
      item.quantity += add_quantity
      item.save
    else
      item = cart_items.create(internal_product: object, quantity: add_quantity, unit_price: object.price)
    end
    item.reload
    item.calculate_totals

    set_last_operation
  end

  def remove_item(object, add_quantity = 1)
    item = find_item(object)
    return unless item

    item.quantity -= add_quantity
    item.save
    item.reload
    item.calculate_totals

    set_last_operation
  end

  def destroy_item(item)
    item = find_item(item.internal_product)
    return unless item

    item.destroy
    set_last_operation
  end

  def gross_total_amount
    #cart_items.sum(:net_total).to_f
    cart_items.sum(:gross_total).to_f
  end

  def gross_total_coupon_amount
    #Continuar aqui
    gross_total = 0
    cart_items.each do |ci|
      get_product = InternalProduct.find(ci.internal_product_id)
      if get_product.present?
        gross_total += ci.quantity * get_product.price
      end
    end
    return gross_total
  end

  def discount_rate
    AmountDiscount.discount_rate(discountable_amount)
  end

  def discount_total
    total = 0
    cart_items.each do |ci|
      if ci.discount_type == "producto"
        total = total + ci.discount_amount
      end
    end

    #return total
    #if total == 0
      #return 0 unless discountable_amount
    if discountable_amount.present?
      discount = total + ((discountable_amount * discount_rate) / 100).round
    else
      discount = total
    end
    #else
    #  return total
    #end
  end

  def net_total_amount
    gross_total_amount - discount_total
  end

  def clear
    cart_items.clear
  end

  def items?
    cart_items.any?
  end
  alias has_items? :items?

  def no_items?
    cart_items.empty?
  end

  def self.shopping_cart_factory(current_user, session_cart_uuid, origin = 'shopping_cart_controller')
    if current_user
      shopping_cart = if current_user.shopping_cart.nil?
                        ShoppingCart.create(
                          user: current_user,
                          last_operation: Time.now,
                          abandoned: false
                        )

                      else
                        current_user.shopping_cart
                      end
      current_user.save

    elsif session_cart_uuid
      shopping_cart = where(session_uuid: session_cart_uuid).first

    elsif origin == 'shopping_cart_controller'
      shopping_cart = create(last_operation: Time.now, abandoned: false)
      shopping_cart.reload

    else
      shopping_cart = nil

    end
    shopping_cart
  end

  def merge_cart(session_cart_uuid)
    return unless session_cart_uuid

    temp_cart = ShoppingCart.where(session_uuid: session_cart_uuid).where(user_id: nil).first
    return unless temp_cart

    temp_cart.cart_items.each do |item|
      add_item(item.internal_product, item.quantity)
    end

    temp_cart.destroy
  end

  private

  def discountable_amount
    cart_items.select { |i| i.discount_active == false }.map { |i| i[:net_total].to_f }.reduce(:+)
  end

  def find_item(object)
    cart_items.where(internal_product: object).first
  end

  def set_last_operation
    self.last_operation = Time.now
    save
  end
end
