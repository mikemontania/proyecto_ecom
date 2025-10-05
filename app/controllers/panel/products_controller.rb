class Panel::ProductsController < Panel::PanelController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_scope, only: :index
  require 'csv'

  # GET /products
  # GET /products.json
  def index; end

  def set_scope
    @products = Product.all

    if params[:q].present?
      @search_text = params[:q]
      basics = search_basics
      product_ids = basics

      @pagy, @products = pagy(@products.where(id: product_ids), items: 20)
    else
      @pagy, @products = pagy(Product.all, items: 20)
    end
  end

  def search_basics
    @products.includes(:category)
             .includes(:subcategory)
             .where("products.name_es ilike ? OR
             categories.name_es ilike ? OR
             subcategories.name_es ilike ?",
                    "%#{@search_text}%",
                    "%#{@search_text}%",
                    "%#{@search_text}%").pluck(:id)
  end

  # GET /products/1
  # GET /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
  def create

    Rails.logger.debug("Producto: #{product_params}")

    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to panel_products_path, notice: 'Producto creado correctamente.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: @products.errors }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  rescue StandardError => e
    message = "Se produjo el siguiente error al guardar: #{e.message}"
    redirect_to panel_products_path, alert: message
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to panel_products_path, notice: 'Producto actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    internal_products = InternalProduct.where(product_id: @product.id)
    internal_products.each do |ip|
      ip.destroy
    end

    @product.destroy
    respond_to do |format|
      format.html { redirect_to panel_products_path, notice: 'Producto eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  def update_prices; end

  def prices_template
    @colArray = []
    @colArray << 'codigo_interno'
    @colArray << 'precio'
    @colArray << 'codigo_um'
    @colArray << 'activo'

    str_csv = CSV.generate(col_sep: ',') do |csv|
      csv << @colArray

      InternalProduct.all.each do |i|
        csv << [i.internal_code.to_s, i.price.to_s, i.measurement_unit_code, i.active]
      end
    end

    respond_to do |format|
      format.csv { send_data str_csv.encode('iso-8859-1'), filename: 'template_precios.csv', type: 'text/csv; charset=iso-8859-1; header=present' }
    end
  rescue StandardError => e
    message = "Error al descargar template: #{e.message}"
    redirect_to panel_price_update_path, alert: message
  end

  def prices_upload
    file = params[:file]

    unless file.blank?

      csv_text = File.open(file.tempfile.to_path.to_s, 'r:ISO-8859-1')

      CSV.parse(csv_text, headers: true, col_sep: ',') do |row|
        internal_code = row['codigo_interno']
        price = row['precio']
        um = row['codigo_um']
        active = ActiveRecord::Type::Boolean.new.cast(row['activo'].to_s.downcase)

        internal_product = InternalProduct.where(internal_code: internal_code).first

        raise "No se encuentra el producto: #{internal_code}" if internal_product.nil?

        internal_product.price = price
        internal_product.measurement_unit_code = um
        internal_product.active = active
        internal_product.save!
      end
    end

    redirect_to panel_price_update_path, notice: 'Precios actualizados correctamente.'
  rescue ActiveRecord::RecordNotFound => e
    message = "Producto no enontrado (#{e})"
    redirect_to panel_price_update_path, alert: message
  rescue ActiveRecord::RecordNotSaved => e
    message = "No se puede actualizar el producto: #{e}"
    redirect_to panel_price_update_path, alert: message
  rescue StandardError => e
    message = "Error al subir precios: #{e.message}"
    redirect_to panel_price_update_path, alert: message
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(
      :name_es, :name_en, :name_br, :description_es, :description_en, :description_br,
      :properties_es, :properties_en, :properties_br, :slug,
      :uses_es, :uses_en, :uses_br, :active, :featured, :category_id, :subcategory_id,
      :brand_id, :order, internal_products_attributes: %i[
        id internal_code measurement_unit_code price active featured presentation_id variety_id
        main is_new image _destroy
      ]
    )
  end
end
