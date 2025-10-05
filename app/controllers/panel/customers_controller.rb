class Panel::CustomersController < Panel::PanelController
  before_action :set_customer, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /customers
  # GET /customers.json
  def index
  end

  def set_scope
    @customers = User.all

    if params[:q].present?
      @search_text = params[:q]
      basics = search_basics
      customer_ids = basics
      @pagy, @customers = pagy(@customers.where(id: customer_ids), items: 20)

    else
      @pagy, @customers = pagy(User.all, items: 20)
    end
  end

  def search_basics
    @customers.where("firstname ilike ? OR
             lastname ilike ? OR
             email ilike ?",
             "%#{@search_text}%",
             "%#{@search_text}%",
             "%#{@search_text}%").pluck(:id)
  end

  # GET /customers/1/edit
  def edit; end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to panel_customers_path, notice: 'Cliente actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to panel_customers_path, notice: 'Cliente eliminado correctamente.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:user).permit(:email, :firstname, :lastname, :id_type, :id_number, :address, :phone, :latitude, :longitude)
  end
end
