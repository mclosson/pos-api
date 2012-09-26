require 'test_helper'

class PaymentTypesControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::PaymentTypesController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_invalid_token_unauthorized
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="BADTOKEN"'    
    ticket_id = sales_tickets(:one).id
    get(:index)
    assert_response :unauthorized
  end

  def test_no_token_unauthorized
    ticket_id = sales_tickets(:one).id
    get(:index)
    assert_response :unauthorized
  end

  def test_successfully_get_payment_types
    token = api_keys(:ingen_sorna_matt).access_token
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'    
    get(:index)
    assert_response :ok
    #assert_match /{"payment_id":".*"}/, @response.body
  end

end
