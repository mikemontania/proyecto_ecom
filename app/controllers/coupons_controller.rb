require 'faraday'
class CouponsController < ApplicationController

  def gimnasios
    @resource_name = User.new
    redirect_to coupon_register_path(promo: 'gimnasios')
  end

  def imanes
    resource_name = User.new
    redirect_to new_registration_path(resource_name, promo: 'imanes')
  end

  def cupon_register
    @promo = params[:promo]
    @resource_name = User.new
  end
end
