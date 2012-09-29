class Api::V1::PaymentTypesController < Api::V1::ApiController
  
  def index
    types = PaymentType.where(location_id: @apikey.location_id)
    render json: types, status: :ok
  end

end
