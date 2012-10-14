class SkusController < ApplicationController
  before_filter :authorize

  def index
    @locations = current_user.account.locations
  end

  def new
    @sku = Sku.new
    @locations = current_user.account.locations.all
    #@genders = current_user.account.genders.all
    #@unit_sizes = current_user.account.unit_sizes.all
    #@suppliers = current_user.account.suppliers.all
    #@articles = current_user.account.articles.all

    # I need to change these to filter by account as above - matt
    @genders = Gender.all
    @unit_sizes = UnitSize.all
    @suppliers = Supplier.all
    @articles = Article.all
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
