class UsersController < ApplicationController
  def index
    @users = current_user.account.users
  end
end
