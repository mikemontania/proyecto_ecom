class Panel::NewslettersController < Panel::PanelController
  before_action :set_newsletter, only: %i[destroy]
  before_action :set_scope, only: :index

  # GET /pages
  # GET /pages.json
  def index
  end

  def set_scope
    @newsletters = Newsletter.all
    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      newsletter_ids = basics

      @pagy, @newsletters = pagy(@newsletters.where(id: newsletter_ids), items: 20)
    else
      @pagy, @newsletters = pagy(Newsletter.all, items: 20)
    end
  end

  def search_basics
    @newsletters.where("name ilike ? OR email ilike ?", "%#{@search_text}%", "%#{@search_text}%").pluck(:id)
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to panel_newsletters_path, notice: 'Usuario eliminado del Newsletter correctamente.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_newsletter
    @newsletter = Newsletter.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def newsletter_params
    params.require(:newsletter).permit(:name, :email)
  end
end
