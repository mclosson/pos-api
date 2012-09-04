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
    @clock_in_time = Time.now
    render json: "{'time':'#{@clock_in_time}'}", status: :ok
  end

  # delete 'sessions/clock'
  def clock_out
    clock_out_time = Time.now
    # Where to store the clock_in_time at?  @variables fall out of scope when the controller instance exits
    #time_worked = @clock_in_time - clock_out_time
    #TODO: temporary fix only
    time_worked = Time.now
    render json: "{'time':'#{time_worked}'}", status: :ok
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
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      token == 'ABCDEF0123456789'
    end
  end

end
