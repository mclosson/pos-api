class SalesTicketsController < ApplicationController
  def index
    @locations = current_user.account.locations
  end

  def show
    @ticket = SalesTicket.find(params[:id])
  end
end
