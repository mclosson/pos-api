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
    render json: '{"message":"Logged out"}', status: :ok
  end

  ####### Time keeping functions

  # post 'sessions/clock'
  def clock_in
    @clock_in_time = Time.new
    render json: '{"time":"#{@clock_in_time}"}', status: ok
  end

  # delete 'sessions/clock'
  def clock_out
    clock_out_time = Time.new
    time_worked = @clock_in_time - clock_out_time
    render json: '{"time":"#{time_worked}"}', status: ok
  end

  private

  def authenticate(username, password)
    users = {'matt' => 'mpass', 'isi' => 'ipass'}
    users[username] == password
  end
end
