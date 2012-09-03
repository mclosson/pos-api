class Api::V1::SessionsController < ApplicationController
  
  respond_to :json
  before_filter :restrict_access, only: [:clock_in, :clock_out]

  def create
    if authenticate(params[:username], params[:password])
      render json: '{"token":"ABCDEF0123456789"}', status: :created
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
    # Need to associate location_id and user_id with a token and pull those out to use here
    # For the moment leave these blank but need to implement this next to support multiple users
    EmployeeClockIn.create(clockin_datetime: @clock_in_time, location_id: nil, user_id: nil)
    render json: "{'time':'#{@clock_in_time}'}", status: :ok
  end

  # delete 'sessions/clock'
  def clock_out
    clock_out_time = Time.now
    clock_in_time = EmployeeClockIn.last.clockin_datetime

    if clock_in_time
      time_worked = clock_in_time - clock_out_time
    else
      time_worked = 0
    end

    render json: "{'time':'#{time_worked}'}", status: :ok
  end

  private

  def authenticate(username, password)
    user = User.find_by_username(username)
    user.authenticate(password) unless user.nil?
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
