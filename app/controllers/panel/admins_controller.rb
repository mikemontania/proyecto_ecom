class Panel::AdminsController < Panel::PanelController
  before_action :set_scope, only: :index

  def index
  end

  def set_scope
    @admins = Admin.all
    if params[:q]
      @search_text = params[:q]
      basics = search_basics
      admin_ids = basics

      @pagy, @admins = pagy(@admins.where(id: admin_ids), items: 20)
    else
      @pagy, @admins = pagy(Admin.all, items: 20)
    end
  end

  def search_basics
    @admins.where("email ilike ?", "%#{@search_text}%").pluck(:id)
  end

  def destroy
    admin_id = params[:id]

    admin = Admin.find(admin_id)
    admin_email = admin.email

    if admin.present?
      admin.delete

      respond_to do |format|
        format.html { redirect_to panel_admins_path, notice: "#{ admin_email } Administrador eliminado." }
      end
    else
      respond_to do |format|
        format.html { redirect_to panel_admins_path, notice: "#{ admin_email } Administrador eliminado." }
      end
    end
  end

end
