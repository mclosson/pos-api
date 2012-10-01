class SalesTicketsController < ApplicationController
  def index
    @locations = current_user.account.locations
  end
end
