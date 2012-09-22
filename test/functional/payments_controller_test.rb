require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::PaymentsController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_invalid_token_unauthorized
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="BADTOKEN"'    
    ticket_id = sales_tickets(:one).id
    parameters = {ticket_id: ticket_id, sku: 100}
    post(:create, parameters)    
    assert_response :unauthorized
  end

  def test_no_token_unauthorized
    ticket_id = sales_tickets(:one).id
    parameters = {ticket_id: ticket_id, sku: 100}
    post(:create, parameters)    
    assert_response :unauthorized
  end

  def test_successfully_add_payment_to_ticket
    token = api_keys(:ingen_sorna_matt).access_token
    ticket_id = sales_tickets(:one).id
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'    
    parameters = {ticket_id: ticket_id, sku: 100}
    post(:create, parameters)    
    assert_response :created
    #assert_match /{"payment_id":".*"}/, @response.body
  end
      
end
