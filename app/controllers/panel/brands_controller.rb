class Panel::BrandsController < Panel::PanelController
  before_action :set_brand, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /brands
  # GET /brands.json
  def index
  end

  def set_scope
    @brands = Brand.all

    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      brand_ids = basics

      @pagy, @brands = pagy(@brands.where(id: brand_ids), items: 20)
    else
      @pagy, @brands = pagy(Brand.all, items: 20)
    end
  end

  def search_basics
    @brands.where("name ilike ?", "%#{@search_text}%").pluck(:id)
  end

  # GET /brands/1
  # GET /brands/1.json
  def show; end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit; end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(brand_params)

    respond_to do |format|
      if @brand.save
        format.html { redirect_to panel_brands_path, notice: 'Marca creada correctamente.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brands/1
  # PATCH/PUT /brands/1.json
  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to panel_brands_path, notice: 'Marca actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to panel_brands_path, notice: 'Marca eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brand
    @brand = Brand.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def brand_params
    params.require(:brand).permit(:name, :active, :order, :logo)
  end
end
