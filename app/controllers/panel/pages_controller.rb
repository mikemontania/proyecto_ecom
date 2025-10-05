class Panel::PagesController < Panel::PanelController
  before_action :set_page, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /pages
  # GET /pages.json
  def index
  end

  def set_scope
    @pages = Page.all

    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      page_ids = basics

      @pagy, @pages = pagy(@pages.where(id: page_ids), items: 20)
    else
      @pagy, @pages = pagy(Page.all, items: 20)
    end
  end

  def search_basics
    @pages.where("title_es ilike ? OR content_es ilike ?", "%#{@search_text}%", "%#{@search_text}%").pluck(:id)
  end


  # GET /pages/1
  # GET /pages/1.json
  def show; end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit; end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to panel_pages_path, notice: 'Página creada correctamente.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to panel_pages_path, notice: 'Página actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to panel_pages_path, notice: 'Página eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(
      :title_es, :title_en, :title_br, :content_es, :content_en, :content_br, :icon, :order, :active
    )
  end
end
