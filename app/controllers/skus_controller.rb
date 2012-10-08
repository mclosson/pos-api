class SkusController < ApplicationController
  before_filter :authorize

  def index
    @locations = current_user.account.locations
  end

  def new
    @sku = Sku.new
    @locations = current_user.account.locations.all
  end

  def create
    @sku = Sku.new(params[:sku])
    if @sku.save
      redirect_to skus_url
    else
      render :new
    end
  end

end
