class Api::V1::PaymentsController < Api::V1::ApiController
  
  def create
    payment = Payment.create(ticket_id: params[:ticket_id],
                             amount: params[:amount],
                             payment_type_id: params[:payment_type_id])
    
    if payment.valid?
      render json: "{\"payment_id\":\"#{payment.id}\"}", status: :created
    else
      error_messages = payment.errors.full_messages.join(', ')
      render json: "{'error': '#{error_messages}", status: :unprocessable_entity
    end
  end

end
