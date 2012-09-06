require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::SessionsController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_successfully_create_new_session
    parameters = {username: 'mclosson', password: 'mpass'}
    post(:create, parameters)    
    assert_response :created
    #TODO: Figure out how to make a more accurrate regex for a valid token
    assert_match /{"token":".*"}/, @response.body
  end

  def test_create_session_invalid_username_or_password
    parameters = {username: 'mclosson', password: 'badpass'}
    post(:create, parameters)    
    assert_response :unauthorized
    assert_equal '{"error":"Invalid username or password"}', @response.body
  end

  def test_clock_in_returns_clock_in_time
    token = api_keys(:ingen_sorna_matt).access_token
    #TODO: Old test token not associated with real account being phased out
    # @request.env['HTTP_AUTHORIZATION'] = 'Token token="ABCDEF0123456789"'    
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'
    post(:clock_in)
    assert_response :ok
    assert_match /{'time':'.*'}/, @response.body
  end

  def test_clock_in_with_no_token_unauthorized
    post(:clock_in)
    assert_response :unauthorized
  end    

  # def test_clock_out_returns_clock_out_time
  #   #TODO: Old test token not associated with real account being phased out
  #   # @request.env['HTTP_AUTHORIZATION'] = 'Token token="ABCDEF0123456789"'    
  #   token = api_keys(:ingen_sorna_matt).access_token
  #   @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'
  #   delete(:clock_out)
  #   assert_response :ok
  #   assert_match /{'time':'.*'}/, @response.body
  # end

  def test_clock_out_with_no_token_unauthorized
    delete(:clock_out)
    assert_response :unauthorized
  end

end