class Api::V1::SkusController < Api::V1::ApiController
  def show
    # need to filter this by Account, then location........
    # must change the next line of code!!!!!!
    # I think I got it now.... Matt Oct 30, 2012
    sku = Sku.where(sku: params[:id], location_id: @apikey.location_id).first
    if sku
      render json: sku, status: :ok
    else
      render json: "{'error': 'SKU not found'}", status: :not_found
    end
  end
end
