require 'test_helper'

class LocationsControllerTest < ActionController::TestCase

  def setup
    @controller = Api::V1::LocationsController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_successfully_get_locations_for_a_given_account
    registration_code = accounts(:ingen).registration_code
    @request.env['X-Registration-Code'] = registration_code
    get(:index)    
    assert_response :ok
    assert_match /\[.*\]/, @response.body
  end

  def test_invalid_registration_code
    @request.env['X-Registration-Code'] = 'BADCODE'
    get(:index)    
    assert_response :not_found
    assert_equal '{"error":"account not found"}', @response.body
  end

end
