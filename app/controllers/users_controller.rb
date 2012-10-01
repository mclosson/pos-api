class UsersController < ApplicationController
  before_filter :authorize

  def index
    @users = current_user.account.users
  end
end
