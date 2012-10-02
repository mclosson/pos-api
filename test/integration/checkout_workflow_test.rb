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

    get("/api/v1/skus/100", request_parameters, request_headers)
    assert_response :ok
    #TODO: Add an assert here to verify the fields returned
    get("/api/v1/skus/101", request_parameters, request_headers)
    assert_response :ok
    #TODO: Add an assert here to verify the fields returned    
    get("/api/v1/skus/102", request_parameters, request_headers)
    assert_response :ok
    #TODO: Add an assert here to verify the fields returned

    post("/api/v1/tickets", request_parameters, request_headers)
    assert_response :created
    assert_match /{"ticket_id":".*"}/, @response.body

    json = ActiveSupport::JSON.decode(@response.body)
    ticket_id = json['ticket_id']

    request_parameters = Hash.new
    request_parameters[:sku] = 100
    post("/api/v1/tickets/#{ticket_id}/skus", request_parameters, request_headers)
    assert_response :created
    assert_match /{"message":".*"}/, @response.body

    request_parameters = Hash.new
    request_parameters[:sku] = 101
    post("/api/v1/tickets/#{ticket_id}/skus", request_parameters, request_headers)
    assert_response :created
    assert_match /{"message":".*"}/, @response.body

    request_parameters = Hash.new
    request_parameters[:sku] = 102
    post("/api/v1/tickets/#{ticket_id}/skus", request_parameters, request_headers)
    assert_response :created
    assert_match /{"message":".*"}/, @response.body
    
    request_parameters = Hash.new
    get("/api/v1/paymenttypes", request_parameters, request_headers)
    assert_response :ok
    assert_match /\[.*\]/, @response.body

    json = ActiveSupport::JSON.decode(@response.body)
    cash = json[0]['id']
    visa = json[4]['id']
    gift = json[3]['id']
    
    request_parameters = Hash.new
    request_parameters[:amount] = 10.50
    request_parameters[:payment_type_id] = cash
    post("/api/v1/tickets/#{ticket_id}/payments", request_parameters, request_headers)
    assert_response :created
    assert_match /{"payment_id":".*"}/, @response.body

    request_parameters = Hash.new
    request_parameters[:amount] = 59.33
    request_parameters[:payment_type_id] = gift
    post("/api/v1/tickets/#{ticket_id}/payments", request_parameters, request_headers)
    assert_response :created
    assert_match /{"payment_id":".*"}/, @response.body

    request_parameters = Hash.new
    request_parameters[:amount] = 35.17
    request_parameters[:payment_type_id] = visa
    post("/api/v1/tickets/#{ticket_id}/payments", request_parameters, request_headers)
    assert_response :created
    assert_match /{"payment_id":".*"}/, @response.body

    request_parameters = Hash.new
    get("/api/v1/tickets/#{ticket_id}/reciept", request_parameters, request_headers)
    assert_response :ok
    assert_match /{"message":".*"}/, @response.body

    delete("/api/v1/sessions/clock", request_parameters, request_headers)
    assert_response :ok
    assert_match /{"time_worked":".*"}/, @response.body

    delete("/api/v1/sessions", request_parameters, request_headers)
    assert_response :ok
    assert_match /{"message":"Logged out"}/, @response.body
  end

end
