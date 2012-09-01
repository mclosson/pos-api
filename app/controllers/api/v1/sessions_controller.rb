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

  private

  def authenticate(username, password)
    users = {'matt' => 'mpass', 'isi' => 'ipass'}
    users[username] == password
  end
end
