class Panel::VarietiesController < Panel::PanelController
  before_action :set_variety, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /varieties
  # GET /varieties.json
  def index
  end

  # GET /varieties/1
  # GET /varieties/1.json
  def show; end

  # GET /varieties/new
  def new
    @variety = Variety.new
  end

  # GET /varieties/1/edit
  def edit; end

  # POST /varieties
  # POST /varieties.json
  def create
    @variety = Variety.new(variety_params)

    respond_to do |format|
      if @variety.save
        format.html { redirect_to panel_varieties_path, notice: 'Variedad creada correctamente' }
        format.json { render :show, status: :created, location: @variety }
      else
        format.html { render :new }
        format.json { render json: @variety.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /varieties/1
  # PATCH/PUT /varieties/1.json
  def update
    respond_to do |format|
      if @variety.update(variety_params)
        format.html { redirect_to panel_varieties_path, notice: 'Variedad actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @variety }
      else
        format.html { render :edit }
        format.json { render json: @variety.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /varieties/1
  # DELETE /varieties/1.json
  def destroy
    @variety.destroy
    respond_to do |format|
      format.html { redirect_to panel_varieties_path, notice: 'Variedad eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  def set_scope
    @varieties = Variety.all
    if params[:q]
      @search_text = params[:q]
      basics = search_basics
      variety_ids = basics

      @pagy, @varieties = pagy(@varieties.where(id: variety_ids), items: 20)
    else
      @pagy, @varieties = pagy(Variety.all, items: 20)
    end
  end

  def search_basics
    @varieties.where("name_es ilike ?", "%#{@search_text}%").pluck(:id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_variety
    @variety = Variety.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def variety_params
    params.require(:variety).permit(:name_es, :name_en, :name_br, :active, :color)
  end
end
