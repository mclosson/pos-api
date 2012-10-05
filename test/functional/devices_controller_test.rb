require 'test_helper'

class DevicesControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::DevicesController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_successfully_link_new_device
    registration_code = accounts(:ingen).registration_code
    @request.env['X-Registration-Code'] = registration_code
    post(:link)    
    assert_response :ok
    assert_match /{}/, @response.body
  end

  def test_invalid_registration_code
    @request.env['X-Registration-Code'] = 'BADCODE'
    post(:link)    
    assert_response :not_found
    assert_equal '{"error":"account not found"}', @response.body
  end

end
