class Api::V1::TicketsController < Api::V1::ApiController
  respond_to :json
  
  def create
    ticket = SalesTicket.create(location_id: @apikey.location_id, sales_person_id: @apikey.user_id)

    if ticket
      render json: "{\"ticket_id\":\"#{ticket.id}\"}", status: :created
    else
      error_messages = ticket.errors.full_messages.join(', ')
      render json: "{'error': '#{error_messages}", status: :unprocessable_entity
    end
  end

  def add_line_item
    ticket = SalesTicket.find(params[:ticket_id])
    if ticket
      if ticket.add_line_item(params[:sku])
        render json: "{\"message\":\"added sku #{params[:sku]}\"}", status: :created 
      else
        render json: "{\"error\":\"could not add sku #{params[:sku]}\"}", status: :unprocessable_entity
      end
    else
      render json: "{\"error\":\"could not add sku #{params[:sku]}\"}", status: :unprocessable_entity
    end
  end
 
end
