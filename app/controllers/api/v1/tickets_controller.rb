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
 
  def reciept
    ticket = SalesTicket.find(params[:ticket_id])
    if ticket
      #TODO: Add check for payments total versus total for checkout here....

      total_paid = ticket.total_paid
      total_cost = ticket.total_cost
      
      if total_paid == total_cost
        #TODO: print_reciept
        render json: "{\"message\":\"Checkout completed printing reciept\"}", status: :ok
      else
        render json: "{\"error\":\"Total paid: #{total_paid} does not match total cost: #{total_cost}\"}", status: :unprocessable_entity
      end
    else
      render json: "{\"error\":\"ticket not found\"}", status: :not_found
    end
  end

end
