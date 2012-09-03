class Api::V1::TicketsController < Api::V1::ApiController
  respond_to :json
  
  def create
    ticket = SalesTicket.create(location_id: nil, sales_person_id: nil)

    if ticket
      render json: "{'ticket_id':'#{ticket.id}'}", status: :created
    else
      error_messages = ticket.errors.full_messages.join(', ')
      render json: "{'error': '#{error_messages}", status: :unprocessable_entity
    end
  end
end