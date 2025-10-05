class Order < ApplicationRecord
  has_many :order_detail, dependent: :destroy
  has_many :bancard_transactions, dependent: :nullify
  belongs_to :payment_method
  belongs_to :delivery_method
  belongs_to :branch
  belongs_to :user
  enum status: { open: 0, closed: 1, canceled: 2 }, _prefix: true
  enum erp_status: { uncomplete: 0, pending: 1, sent: 2, error: 3 }
  after_save :send_order_email

  DELIVERY_PAYMENT_METHODS = [
    { name: 'Efectivo', value: 'efectivo' },
    { name: 'Tarjeta', value: 'tarjeta' },
    { name: 'Transferencia bancaria', value: 'transferencia' }
  ].freeze

  def to_json_for_service

    order_for_service = {
      order_id: id,
      order_date: created_at.strftime('%F'),
      tax_number_type: tax_number_type,
      tax_number: tax_number,
      tax_name: tax_name,
      order_gross_total: gross_total.to_f,
      order_discount_rate: discount_rate.to_f,
      cupon_code: coupon_code,
      order_discount_total: discount_total.to_f,
      order_net_total: net_total.to_f,
      username: format('%<fullname>s', { fullname: user.fullname }),
      user_email: user.email,
      user_phone: user.phone,
      user_id_number: user.id_number,
      user_id_type: user.id_type,
      delivery_method: delivery_method.internal_name,
      shipping_phone: shipping_phone,
      shipping_address: shipping_address,
      shipping_observation: shipping_observation,
      shipping_department: shipping_department,
      shipping_city: shipping_city,
      shipping_neighborhood: shipping_neighborhood,
      latitude: latitude,
      longitude: longitude,
      billing_address: billing_address,
      billing_phone: billing_phone,
      billing_observation: billing_observation,
      billing_department: billing_department,
      billing_city: billing_city,
      billing_neighborhood: billing_neighborhood,
      payment_status: paid == true ? 'paid' : 'pending',
      payment_method: payment_method.internal_name,
      payment_date: paid == true ? payment_date.strftime('%F') : '',
      payment_time: paid == true ? payment_date.strftime('%T') : '',
      payment_code: paid == true ? payment_transaction_id.to_s : '',
      branch_name: branch.name,
      branch_erp_code: branch.erp_code,
      delivery_payment_method: delivery_payment_method,
      bank_transfer_reference: bank_transfer_reference,
      order_detail: detail_to_json
    }
  end

  def detail_to_json
    detail = []
    order_detail.each do |d|
      detail_for_service = {
        product_id: d.internal_product.id,
        product_name: d.internal_product.full_name("es"), #d.internal_product.full_name(@lang),
        internal_product_code: d.internal_product.internal_code,
        presentation_id: d.internal_product.presentation_id,
        presentation_name: d.internal_product.presentation.name,
        measurement_unit_code: d.internal_product.measurement_unit_code,
        brand_id: d.internal_product.product.brand_id,
        brand_name: d.internal_product.product.brand.name,
        variety_id: d.internal_product.variety_id,
        variety_name: d.internal_product.variety.name,
        quantity: d.quantity.to_i,
        unit_price: d.unit_price.to_f,
        gross_total: d.gross_total.to_f,
        discount_rate: d.discount_rate.to_f,
        discount_amount: d.discount_amount.to_f,
        net_total: d.net_total.to_f
      }

      detail << detail_for_service
    end
    detail
  end

  def set_branch_by_distance
    branches = Branch.where(active: true)

    nearest_branch_id = 0
    nearest_branch_distance = Float::MAX

    branches.each do |b|
      next unless b.latitude.present? && b.longitude.present?

      distance = Geocoder::Calculations.distance_between([latitude, longitude], [b.latitude, b.longitude])
      next unless distance < nearest_branch_distance

      nearest_branch_distance = distance
      nearest_branch_id = b.id
    end

    self.branch_id = nearest_branch_id
  end

  private

  def send_order_email
    OrderMailer.order_email(self).deliver if status == 'closed' && mail_sent_at.nil?
  end
end
