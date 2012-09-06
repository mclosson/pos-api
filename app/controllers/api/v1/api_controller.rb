class Api::V1::ApiController < ApplicationController
  respond_to :json
  before_filter :restrict_access

  private

  # Check to see if the passed in token matches the test token
  # If so return true to allow the request.  If not then look
  # up the token in the cache first, if still not found look
  # if up in the database.  If it is found cache the result
  # and return true to allow the request.  If it is still not
  # found in the database then we have someone playing games
  # and we need to return false reject the request as invalid.
  # It could also be someone interacting with the API wrong.
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      test_token?(token) || token_cached?(token) || find_and_cache_token(token)
    end
  end

  def test_token?(token)
    token == 'ABCDEF0123456789'
  end

  def token_cached?(token)
    Rails::cache.read("apikey_#{token}")
  end

  def find_and_cache_token(token)
    begin
      @apikey = ApiKey.find(token)
      Rails::cache.write("apikey_#{token}", @apikey) unless @apikey.nil?
    rescue ActiveRecord::RecordNotFound
      @apikey = nil
    ensure
      return !@apikey.nil?
    end
  end

end