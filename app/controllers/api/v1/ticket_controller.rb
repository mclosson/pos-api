class Api::V1::TicketController < Api::V1::ApiController
  respond_to :json
  
  def create
    if params[:location_id]
      # create the ticket, here's some fake json for now....
      render json: '{"ticket_id":"5736282738"}', status: 200
    else
      render json: '{"error":"Could not create ticket becase..."}', status: 422
    end
  end
end