class PagesController < ApplicationController
  before_filter :authorize

  def index
    @locations = current_user.account.locations
    @account = current_user.account
  end
end
