class Panel::BranchesController < Panel::PanelController
  before_action :set_branch, only: %i[show edit update destroy]
  before_action :set_scope, only: :index

  # GET /branches
  # GET /branches.json
  def index
  end

  def set_scope
    @branches = Branch.all

    if params[:q]
      @search_text = params[:q]
      basics = search_basics

      branch_ids = basics

      @pagy, @branches = pagy(@branches.where(id: branch_ids), items: 20)
    else
      @pagy, @branches = pagy(Branch.all, items: 20)
    end
  end

  def search_basics
    @branches.where("name_es ilike ?", "%#{@search_text}%").pluck(:id)
  end

  # GET /branches/1
  # GET /branches/1.json
  def show; end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit; end

  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to panel_branch_path(@branch), notice: 'Sucursal creada correctamente.' }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to panel_branches_path, notice: 'Sucursal actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    @branch.destroy
    respond_to do |format|
      format.html { redirect_to panel_branches_path, notice: 'Sucursal eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_branch
    @branch = Branch.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def branch_params
    params.require(:branch).permit(:name_es, :name_en, :name_br, :address, :image, :phone, :hours, :latitude, :longitude, :erp_code, :active, :iframe)
  end
end
