class Api::V1::SessionsController < ApplicationController
  respond_to :json

  def create
    if params[:username] && params[:password] && authenticate(params[:username], params[:password])
      render json: '{"token":"ABCDEF0123456789"}', status: :created
    else
      render json: '{"error":"Invalid username or password"}', status: :unauthorized
    end
  end

  def destroy
    if params[:token] == "ABCDEF0123456789"
      render json: '{"message":"Logged out"}', status: :ok
    else
      render json: '{"error:":"Invalid token"}', status: :unauthorized
    end
  end

####### Time keeping functions

## Matt, notice we are checking for token everywhere, perhas a good oportunity to refactor this logic out of
## every method

# post 'sessions/clock'
  def clock_in
    if params[:token] == "ABCDEF0123456789"
      @clock_in_time = Time.new
      render json: '{"time":"#{@clock_in_time}"}', status: ok
    else
      render json: '{"error:":"Invalid token"}', status: :unauthorized
  end

# delete 'sessions/clock'
  def clock_out
    clock_out_time = Time.new
    time_worked = @clock_in_time - clock_out_time
    render json: '{"time":"#{time_worked}"}', status: ok
    else
      render json: '{"error:":"Invalid token"}', status: :unauthorized
  end


  private

  def authenticate(username, password)
    users = {'matt' => 'mpass', 'isi' => 'ipass'}
    users[username] == password
  end
end
