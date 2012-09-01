require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::SessionsController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_successfully_create_new_session
    parameters = {username: 'matt', password: 'mpass'}
    post(:create, parameters)    
    assert_response :success
    assert_equal '{"token":"ABCDEF0123456789"}', @response.body
  end

  def test_create_session_invalid_username_or_password
    parameters = {username: 'matt', password: 'badpass'}
    post(:create, parameters)    
    assert_response 500
    assert_equal '{"error":"Invalid username or password"}', @response.body
  end

end