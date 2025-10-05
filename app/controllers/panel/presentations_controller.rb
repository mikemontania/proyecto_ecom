class Panel::PresentationsController < Panel::PanelController
  before_action :set_presentation, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /presentations
  # GET /presentations.json
  def index
  end

  def set_scope
    @presentations = Presentation.all
    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      presentation_ids = basics

      @pagy, @presentations = pagy(@presentations.where(id: presentation_ids).order(size: :asc)
        .order(name_es: :asc), items: 20)
    else
      @pagy, @presentations = pagy(Presentation.all.order(size: :asc).order(name_es: :asc), items: 20)
    end
  end

  def search_basics
    @presentations.where("name_es ilike ?", "%#{@search_text}%").pluck(:id)
  end

  # GET /presentations/1
  # GET /presentations/1.json
  def show; end

  # GET /presentations/new
  def new
    @presentation = Presentation.new
  end

  # GET /presentations/1/edit
  def edit; end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation = Presentation.new(presentation_params)

    respond_to do |format|
      if @presentation.save
        format.html { redirect_to panel_presentations_path, notice: 'Presentación creada correctamente.' }
        format.json { render :show, status: :created, location: @presentation }
      else
        format.html { render :new }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presentations/1
  # PATCH/PUT /presentations/1.json
  def update
    respond_to do |format|
      if @presentation.update(presentation_params)
        format.html { redirect_to panel_presentations_path, notice: 'Presentación actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @presentation }
      else
        format.html { render :edit }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presentations/1
  # DELETE /presentations/1.json
  def destroy
    @presentation.destroy
    respond_to do |format|
      format.html { redirect_to panel_presentations_path, notice: 'Presentación eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_presentation
    @presentation = Presentation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def presentation_params
    params.require(:presentation).permit(:name_es, :name_en, :name_br, :active, :icon, :size)
  end
end
