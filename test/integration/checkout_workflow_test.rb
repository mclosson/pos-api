require 'test_helper'
 
class CheckoutWorkflowTest < ActionDispatch::IntegrationTest
 
  test "login, clockin and create a ticket, clockout, logout" do
    request_headers = Hash.new
    request_headers['Accept'] = 'application/json'
    request_headers['Content-type'] = 'application/json'

    request_parameters = Hash.new
    request_parameters[:username] = 'mclosson'
    request_parameters[:password] = 'mpass'

    post("/api/v1/sessions", request_parameters, request_headers)
    assert_response :created
    assert_match /{"token":".*"}/, @response.body
    json = ActiveSupport::JSON.decode(@response.body)
    token = json['token']

    request_headers['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'
    request_parameters = Hash.new
    post("/api/v1/sessions/clock", request_parameters, request_headers)
    assert_response :ok
    assert_match /{'time':'.*'}/, @response.body

    post("/api/v1/tickets", request_parameters, request_headers)
    assert_response :created
    assert_match /{"ticket_id":".*"}/, @response.body

    #TODO: Add line items to ticket
    #TODO: Remove a line item from the ticket
    #TODO: Collect payments
    #TODO: Totalize items and issue a reciept

    delete("/api/v1/sessions/clock", request_parameters, request_headers)
    assert_response :ok
    assert_match /{"time_worked":".*"}/, @response.body

    delete("/api/v1/sessions", request_parameters, request_headers)
    assert_response :ok
    assert_match /{"message":"Logged out"}/, @response.body
  end

end