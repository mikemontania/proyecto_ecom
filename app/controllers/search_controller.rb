class SearchController < ApplicationController
  def search
    @q = params[:q]
    @product_list = InternalProduct.search(@q, @lang)

    respond_to do |format|
      format.html { render :search }
    end
  end

  private

  def search_params
    params.require(:search).permit(:q)
  end
end
