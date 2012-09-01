require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::SessionsController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_successfully_create_ticket
    @request.env['HTTP_AUTHORIZATION'] = 'Token token=\"ABCDEF0123456789\"'
    parameters = {location: 'testlocation'}
    post(:create, parameters)    
    assert_response :created
    assert_equal '{"ticket_id":"5736282738"}', @response.body
  end

  def test_create_ticket_no_location_given
    @request.env['Authorization Token: token'] = 'ABCDEF0123456789'    
    post :create    
    assert_response :unprocessable_entity
    assert_equal '{"error":"Could not create ticket becase..."}', @response.body
  end

end