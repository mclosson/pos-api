class Api::V1::ApiController < ApplicationController
  respond_to :json
  before_filter :restrict_access

  private

  # Look up the token in the cache first, if not found look
  # it up in the database.  If it is found cache the result
  # and return true to allow the request.  If it is still not
  # found in the database then we have someone playing games
  # and we need to return false reject the request as invalid.
  # It could also be someone interacting with the API wrong.
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      token_cached?(token) || find_and_cache_token(token)
    end
  end

  def token_cached?(token)
    hash = Rails::cache.read("apikey_#{token}")    
    return false unless hash
    @apikey = ApiKey.new(
      id: hash[:id], access_token: hash[:access_token], 
      location_id: hash[:location_id], user_id: hash[:user_id]
    )
    return @apikey.access_token == token
  end

  def find_and_cache_token(token)
    begin
      @apikey = ApiKey.find_by_access_token(token)
      Rails::cache.write("apikey_#{token}", @apikey) unless @apikey.nil?
    rescue ActiveRecord::RecordNotFound
      @apikey = nil
    ensure
      return !@apikey.nil?
    end
  end

end