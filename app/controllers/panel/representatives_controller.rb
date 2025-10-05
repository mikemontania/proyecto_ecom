class Panel::RepresentativesController < Panel::PanelController
  before_action :set_representative, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /representatives
  # GET /representatives.json
  def index
  end

  def set_scope
    @representatives = Representative.all

    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      representative_ids = basics

      @pagy, @representatives = pagy(@representatives.where(id: representative_ids), items: 20)
    else
      @pagy, @representatives = pagy(Representative.all, items: 20)
    end
  end

  def search_basics
    @representatives.where("name ilike ? OR email ilike ?", "%#{@search_text}%", "%#{@search_text}%").pluck(:id)
  end

  # GET /representatives/1
  # GET /representatives/1.json
  def show; end

  # GET /representatives/new
  def new
    @representative = Representative.new
  end

  # GET /representatives/1/edit
  def edit; end

  # POST /representatives
  # POST /representatives.json
  def create
    @representative = Representative.new(representative_params)

    respond_to do |format|
      if @representative.save
        format.html { redirect_to panel_representatives_path, notice: 'Representante creado correctamente.' }
        format.json { render :show, status: :created, location: @representative }
      else
        format.html { render :new }
        format.json { render json: @representative.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /representatives/1
  # PATCH/PUT /representatives/1.json
  def update
    respond_to do |format|
      if @representative.update(representative_params)
        format.html { redirect_to panel_representatives_path, notice: 'Representante actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @representative }
      else
        format.html { render :edit }
        format.json { render json: @representative.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /representatives/1
  # DELETE /representatives/1.json
  def destroy
    @representative.destroy
    respond_to do |format|
      format.html { redirect_to panel_representatives_path, notice: 'Representante eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_representative
    @representative = Representative.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def representative_params
    params.require(:representative).permit(:name, :address, :phone, :email, :website, :latitude, :longitude)
  end
end
