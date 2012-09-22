class Api::V1::SessionsController < ActionController::Base
  
  include TokenAuthenticatable
  respond_to :json

  # The method :restrict_access which is called in this before_filter is
  # defined in the TokenAuthenticatable module we included above
  before_filter :restrict_access, only: [:destroy, :clock_in, :clock_out]

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
    # Need to remove token from cache and database
    Rails::cache.delete("apikey_#{@apikey.access_token}")
    @apikey.destroy
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
      time_worked = lasttimecard.clockout_datetime - lasttimecard.clockin_datetime
      render json: "{\"time_worked\":\"#{time_worked}\"}", status: :ok
    else
      render json: "{\"error\":\"Could not find your last clock in\"}", status: :precondition_failed
    end
  end

  private

  def authenticate(username, password)
    user = User.find_by_username(username)
    user.nil? ? false : user.authenticate(password)
  end

end
