class BrandsController < ApplicationController
  def index
    @brands = Brand.where(active: true).order(order: :asc)
  end

  def show
    @brand = Brand.friendly.find(params[:id])
  end
end
