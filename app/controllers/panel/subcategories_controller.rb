class Panel::SubcategoriesController < Panel::PanelController
  before_action :set_subcategory, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /subcategories
  # GET /subcategories.json
  def index
  end

  def set_scope
    @subcategories = Subcategory.all

    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      subcategory_ids = basics
      @pagy, @subcategories = pagy(@subcategories.where(id: subcategory_ids), items: 20)
    else
      @pagy, @subcategories = pagy(Subcategory.all, items: 20)
    end
  end

  def search_basics
    @subcategories.includes(:category)
      .where("subcategories.name_es ilike ? OR
             categories.name_es ilike ?", "%#{@search_text}%", "%#{@search_text}%").pluck(:id)
  end

  # GET /subcategories/1
  # GET /subcategories/1.json
  def show; end

  # GET /subcategories/new
  def new
    @subcategory = Subcategory.new
  end

  # GET /subcategories/1/edit
  def edit; end

  # POST /subcategories
  # POST /subcategories.json
  def create
    @subcategory = Subcategory.new(subcategory_params)

    respond_to do |format|
      if @subcategory.save
        format.html { redirect_to panel_subcategories_path, notice: 'Subcategoría creada correctamente.' }
        format.json { render :show, status: :created, location: @subcategory }
      else
        format.html { render :new }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subcategories/1
  # PATCH/PUT /subcategories/1.json
  def update
    respond_to do |format|
      if @subcategory.update(subcategory_params)
        format.html { redirect_to panel_subcategories_path, notice: 'Subcategoría actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @subcategory }
      else
        format.html { render :edit }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subcategories/1
  # DELETE /subcategories/1.json
  def destroy
    @subcategory.destroy
    respond_to do |format|
      format.html { redirect_to panel_subcategories_url, notice: 'Subcategoría eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subcategory
    @subcategory = Subcategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def subcategory_params
    params.require(:subcategory).permit(:name_es, :name_en, :name_br, :active, :category_id)
  end
end
