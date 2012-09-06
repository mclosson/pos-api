class Api::V1::SessionsController < ApplicationController
  
  respond_to :json
  before_filter :restrict_access, only: [:clock_in, :clock_out]

  def create
    user = authenticate(params[:username], params[:password])
    if user
      location = user.default_location

      if params[:location] && user.location_valid?(params[:location])
        location = params[:location]
      end

      apikey = ApiKey.create(user_id: user.id, location_id: location)
      render json: "{\"token\":\"#{apikey.access_token}\"}", status: :created
    else
      render json: '{"error":"Invalid username or password"}', status: :unauthorized
    end
  end

  def destroy
    render json: '{"message":"Logged out"}', status: :ok
  end

  ####### Time keeping functions

  # post 'sessions/clock'
  def clock_in
    clock_in_time = Time.now

    timecard = EmployeeClockIn.create(clockin_datetime: clock_in_time, 
                                       location_id: @apikey.location_id,
                                       user_id: @apikey.user_id)

    if timecard
      render json: "{'time':'#{clock_in_time}'}", status: :ok
    else
      render json: "{\"error\":\"Could not clock in\"}", status: :precondition_failed
    end
  end

  # delete 'sessions/clock'
  def clock_out
    clock_out_time = Time.now
    # Where to store the clock_in_time at?  @variables fall out of scope when the controller instance exits
    #time_worked = @clock_in_time - clock_out_time
    #TODO: temporary fix only
    lasttimecard = EmployeeClockIn.where(user_id: @apikey.user_id).last
    if lasttimecard
      lasttimecard.clockout_datetime = clock_out_time
      lasttimecard.save
      timeworked = lasttimecard.clockout_datetime - lasttimecard.clockin_datetime
      render json: "{\"time_worked\":\"#{time_worked}\"}", status: :ok
    else
      render json: "{\"error\":\"Could not find your last clock in\"}", status: :precondition_failed
    end
  end

  private

  def authenticate(username, password)
    user = User.find_by_username(username)
    user.authenticate(password)
  end

  # For most other controllers this method is defined and inherited
  # from api_controller, however sessions_controller does not inherit
  # from api_controller so we will replicate this check here for specific
  # methods like clock_in and clock_out

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
