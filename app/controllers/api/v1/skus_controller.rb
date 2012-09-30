class Api::V1::SkusController < Api::V1::ApiController
  def show
    #sample = Sku.test_data(params[:id])
    sku = Sku.find_by_sku(params[:id])
    if sku
      render json: sku, status: :ok
    else
      render json: "{'error': 'SKU not found'}", status: :not_found
    end
  end
end
