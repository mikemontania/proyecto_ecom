class Panel::OrdersController < Panel::PanelController
  before_action :set_order, only: %i[show]
  before_action :set_scope_pending, only: :index_pending
  before_action :set_scope_sent, only: :index_sent
  before_action :set_scope_canceled, only: :index_canceled

  def index_pending
  end

  def index_sent
  end

  def index_canceled
  end

  def show; end

  private

  def set_scope_pending
    @orders = Order.where(erp_status: :pending).order(created_at: :desc)

    if params[:q] && !params[:q].empty?
      @search_text = params[:q]
      basics = search_basics

      order_pending_ids = basics

      @pagy, @orders = pagy(@orders.where(id: order_pending_ids), items: 20)
    else
      @pagy, @orders = pagy(Order.where(erp_status: :pending).order(created_at: :desc), items: 20)
    end
  end

  def set_scope_sent
    @orders = Order.where(erp_status: :sent).order(created_at: :desc)

    if params[:q] && !params[:q].empty?
      @search_text = params[:q]
      basics = search_basics

      order_sent_ids = basics

      @pagy, @orders = pagy(@orders.where(id: order_sent_ids), items: 20)
    else
      @pagy, @orders = pagy(Order.where(erp_status: :sent).order(created_at: :desc), items: 20)
    end
  end

  def set_scope_canceled
    @orders = Order.where(status: :canceled).or(Order.where(erp_status: :uncomplete)).order(created_at: :desc)

    if params[:q] && !params[:q].empty?
      @search_text = params[:q]
      basics = search_basics

      order_canceled_ids = basics

      @pagy, @orders = pagy(@orders.where(id: order_canceled_ids), items: 20)
    else
      @pagy, @orders = pagy(Order.where(status: :canceled).or(Order.where(erp_status: :uncomplete)).order(created_at: :desc), items: 20)
    end
  end

  def search_basics
    @orders.joins(:user)
      .where("users.firstname ilike ? OR
      users.lastname ilike ? OR
      users.email ilike ? OR
      orders.tax_name ilike ?",
      "%#{@search_text}%", "%#{@search_text}%", "%#{@search_text}%", "%#{@search_text}%").pluck(:id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end
end
