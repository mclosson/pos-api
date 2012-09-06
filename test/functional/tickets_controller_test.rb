require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::TicketsController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_successfully_create_ticket
    token = api_keys(:ingen_sorna_matt).access_token
    location_id = locations(:sorna).id
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'    
    parameters = {location: location_id}
    post(:create, parameters)    
    assert_response :created
    assert_match /{"ticket_id":".*"}/, @response.body
    #TODO: Add an assert to ensure the ticket got our location and user_id
  end

  def test_create_ticket_no_location_given_uses_default_location
    token = api_keys(:ingen_sorna_matt).access_token
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'    
    post :create    
    assert_response :created
    assert_match /{"ticket_id":".*"}/, @response.body
    #TODO: Add an assert to ensure the ticket got our default_location and user_id    
  end

  def test_invalid_token_unauthorized
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="BADTOKEN"'    
    post(:create)
    assert_response :unauthorized
  end

  def test_no_token_unauthorized
    parameters = {location: 'testlocation'}
    post(:create, parameters)
    assert_response :unauthorized
  end
      
end