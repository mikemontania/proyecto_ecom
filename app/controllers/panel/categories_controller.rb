class Panel::CategoriesController < Panel::PanelController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /categories
  # GET /categories.json
  def index
  end

  def set_scope
    @categories = Category.all

    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      category_ids = basics
      @pagy, @categories = pagy(@categories.where(id: category_ids), items: 20)
    else
      @pagy, @categories = pagy(Category.all, items: 20)
    end
  end

  def search_basics
    @categories.where("name_es ilike ?", "%#{@search_text}%").pluck(:id)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show; end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to panel_categories_path, notice: 'Categoría creada correctamente.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to panel_categories_path, notice: 'Categoría actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to panel_categories_path, notice: 'Categoría eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name_es, :name_en, :name_br, :active, :icon)
  end
end
