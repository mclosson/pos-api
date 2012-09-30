require 'test_helper'

class SkusControllerTest < ActionController::TestCase
  
  def setup
    @controller = Api::V1::SkusController.new
    @request.env['Accept'] = 'application/json'
    @request.env['Content-type'] = 'application/json'
  end

  def test_successfully_get_sku
    token = api_keys(:ingen_sorna_matt).access_token
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'    
    parameters = {id: '100'}
    get(:show, parameters)    
    assert_response :ok
    assert_match /{.*}/, @response.body
    #TODO: Add an assert to ensure the sku has the proper fields returned
  end

  def test_get_invalid_sku
    token = api_keys(:ingen_sorna_matt).access_token
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="' + token + '"'    
    parameters = {id: 'BADSKU'}
    get(:show, parameters)    
    assert_response :not_found
    assert_match /{'error': 'SKU not found'}/, @response.body
  end

  def test_invalid_token_unauthorized
    @request.env['HTTP_AUTHORIZATION'] = 'Token token="BADTOKEN"'    
    parameters = {id: '100'}
    get(:show, parameters)
    assert_response :unauthorized
  end

  def test_no_token_unauthorized
    parameters = {id: '100'}
    get(:show, parameters)
    assert_response :unauthorized
  end
      
end
