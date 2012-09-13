class Api::V1::SkusController < Api::V1::ApiController
  def show
    sample = Sku.test_data(params[:id])
    if sample
      render json: Sku.new(sample), status: :ok
    else
      render json: "{'error': 'SKU not found'}", status: :not_found
    end
  end
end
