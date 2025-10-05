class Panel::SlidersController < Panel::PanelController
  before_action :set_slider, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /sliders
  # GET /sliders.json
  def index
  end

  def set_scope
    @sliders = Slider.all
    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      slider_ids = basics

      @pagy, @sliders = pagy(@sliders.where(id: slider_ids), items: 20)
    else
      @pagy, @sliders = pagy(Slider.all, items: 20)
    end
  end

  def search_basics
    @sliders.where("name ilike ?", "%#{@search_text}%").pluck(:id)
  end

  # GET /sliders/1
  # GET /sliders/1.json
  def show; end

  # GET /sliders/new
  def new
    @slider = Slider.new
  end

  # GET /sliders/1/edit
  def edit; end

  # POST /sliders
  # POST /sliders.json
  def create
    @slider = Slider.new(slider_params)

    respond_to do |format|
      if @slider.save
        format.html { redirect_to panel_sliders_path, notice: 'Slider creado correctamente.' }
        format.json { render :show, status: :created, location: @slider }
      else
        format.html { render :new }
        format.json { render json: @slider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sliders/1
  # PATCH/PUT /sliders/1.json
  def update
    respond_to do |format|
      if @slider.update(slider_params)
        format.html { redirect_to panel_sliders_path, notice: 'Slider actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @slider }
      else
        format.html { render :edit }
        format.json { render json: @slider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sliders/1
  # DELETE /sliders/1.json
  def destroy
    @slider.destroy
    respond_to do |format|
      format.html { redirect_to panel_sliders_path, notice: 'Slider eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_slider
    @slider = Slider.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def slider_params
    params.require(:slider).permit(:name, :link, :active, :order, :image_desktop, :image_mobile)
  end
end
