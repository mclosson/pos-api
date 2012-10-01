class LocationsController < ApplicationController
  before_filter :authorize

  def index
    @locations = current_user.account.locations
  end
end
