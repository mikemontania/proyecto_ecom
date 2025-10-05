class Panel::AmountDiscountsController < Panel::PanelController
  before_action :set_amount_discount, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /amount_discounts
  # GET /amount_discounts.json
  def index
  end

  # GET /amount_discounts/1
  # GET /amount_discounts/1.json
  def show; end

  # GET /amount_discounts/new
  def new
    @amount_discount = AmountDiscount.new
  end

  # GET /amount_discounts/1/edit
  def edit; end

  # POST /amount_discounts
  # POST /amount_discounts.json
  def create
    @amount_discount = AmountDiscount.new(amount_discount_params)

    respond_to do |format|
      if @amount_discount.save
        format.html { redirect_to panel_amount_discounts_path, notice: 'Descuento por importe creado correctamente.' }
        format.json { render :show, status: :created, location: @amount_discount }
      else
        format.html { render :new }
        format.json { render json: @amount_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amount_discounts/1
  # PATCH/PUT /amount_discounts/1.json
  def update
    respond_to do |format|
      if @amount_discount.update(amount_discount_params)
        format.html { redirect_to panel_amount_discounts_path, notice: 'Descuento por importe actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @amount_discount }
      else
        format.html { render :edit }
        format.json { render json: @amount_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amount_discounts/1
  # DELETE /amount_discounts/1.json
  def destroy
    @amount_discount.destroy
    respond_to do |format|
      format.html { redirect_to panel_amount_discounts_path, notice: 'Descuento por importe eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  def set_scope
    @amount_discounts = AmountDiscount.all.order(:min_amount)

    if params[:q]
      @search_text = params[:q]
      basics = search_basics
      amount_discount_ids = basics

      @pagy, @amount_discounts = pagy(@amount_discounts.where(id: amount_discount_ids), items: 20)
    else
      @pagy, @amount_discounts = pagy(AmountDiscount.all.order(:min_amount), items: 20)
    end
  end

  def search_basics
    @amount_discounts.where("CAST(min_amount as TEXT) ilike ? OR CAST(max_amount as TEXT) ilike ?",
    "%#{@search_text}%", "%#{@search_text}%").pluck(:id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_amount_discount
    @amount_discount = AmountDiscount.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def amount_discount_params
    params.require(:amount_discount).permit(:min_amount, :max_amount, :discount_rate, :begin_date, :end_date)
  end
end
