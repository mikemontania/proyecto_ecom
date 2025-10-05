class Panel::ProductDiscountsController < Panel::PanelController
  before_action :set_product_discount, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /product_discounts
  # GET /product_discounts.json
  def index
  end

  def set_scope
    @product_discounts = ProductDiscount.all.order(:internal_product_id)

    if params[:q]
      @search_text = params[:q]
      basics = search_basics
      product_discount_ids = basics
      @pagy, @product_discounts = pagy(@product_discounts.where(id: product_discount_ids), items: 20)
    else
      @pagy, @product_discounts = pagy(ProductDiscount.all.order(:internal_product_id), items: 20)
    end
  end

  def search_basics
    @product_discounts.where("CAST(min_quantity as TEXT) ilike ? OR CAST(max_quantity as TEXT) ilike ? OR
                             product_name ilike ?",
                             "%#{@search_text}%", "%#{@search_text}%", "%#{@search_text}%").pluck(:id)
  end
  # GET /product_discounts/1
  # GET /product_discounts/1.json
  def show; end

  # GET /product_discounts/new
  def new
    @product_discount = ProductDiscount.new
  end

  # GET /product_discounts/1/edit
  def edit; end

  # POST /product_discounts
  # POST /product_discounts.json
  def create
    find_product = InternalProduct.find(params[:product_discount][:internal_product_id])

    if find_product.present?
      product_name = find_product.full_name('es')
    else
      product_name = ""
    end

    @product_discount = ProductDiscount.create(product_discount_params)
    @product_discount.product_name = product_name

    respond_to do |format|
      if @product_discount.save
        format.html { redirect_to panel_product_discounts_path, notice: 'Descuento por producto creado correctamente.' }
        format.json { render :show, status: :created, location: @product_discount }
      else
        format.html { render :new }
        format.json { render json: @product_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  #Temporal
  def update_all
    ProductDiscount.all.each do |disc|
      find_in_prod = InternalProduct.find(disc.internal_product_id)

      if find_in_prod.present?
          disc.product_name = find_in_prod.full_name('es')
          disc.save!
      end
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Todo listo" }
    end
  end

  # PATCH/PUT /product_discounts/1
  # PATCH/PUT /product_discounts/1.json
  def update

    respond_to do |format|
      if @product_discount.update(product_discount_params)

        find_product = InternalProduct.find(params[:product_discount][:internal_product_id])

        if find_product.present?
          @product_discount.product_name = find_product.full_name('es')
          @product_discount.save
        end

        format.html { redirect_to panel_product_discounts_path, notice: 'Descuento por producto actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @product_discount }
      else
        format.html { render :edit }
        format.json { render json: @product_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_discounts/1
  # DELETE /product_discounts/1.json
  def destroy
    @product_discount.destroy
    respond_to do |format|
      format.html { redirect_to panel_product_discounts_path, notice: 'Descuento por producto eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_product_discount
    @product_discount = ProductDiscount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_discount_params
    params.require(:product_discount).permit(:internal_product_id, :product_name, :min_quantity, :max_quantity, :discount_rate, :begin_date, :end_date)
  end
end
