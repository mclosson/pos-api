class LocationsController < ApplicationController

  before_filter :authorize

  def new
    # Do we need this in the new action?  Maybe we just need Location.new
    #@location = current_user.account.locations.build
    @location = Location.new
  end

  def index
    @locations = current_user.account.locations
  end

  def create
    @location = current_user.account.locations.build(params[:location])
    if @location.save
      redirect_to locations_url
    else
      render :new
    end
  end

end
