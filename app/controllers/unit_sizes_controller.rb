class UnitSizesController < ApplicationController
  before_filter :authorize

  # GET /unit_sizes
  # GET /unit_sizes.json
  def index
    @unit_sizes = UnitSize.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @unit_sizes }
    end
  end

  # GET /unit_sizes/1
  # GET /unit_sizes/1.json
  def show
    @unit_size = UnitSize.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unit_size }
    end
  end

  # GET /unit_sizes/new
  # GET /unit_sizes/new.json
  def new
    @unit_size = UnitSize.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unit_size }
    end
  end

  # GET /unit_sizes/1/edit
  def edit
    @unit_size = UnitSize.find(params[:id])
  end

  # POST /unit_sizes
  # POST /unit_sizes.json
  def create
    @unit_size = UnitSize.new(params[:unit_size])

    respond_to do |format|
      if @unit_size.save
        format.html { redirect_to @unit_size, notice: 'Unit size was successfully created.' }
        format.json { render json: @unit_size, status: :created, location: @unit_size }
      else
        format.html { render action: "new" }
        format.json { render json: @unit_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /unit_sizes/1
  # PUT /unit_sizes/1.json
  def update
    @unit_size = UnitSize.find(params[:id])

    respond_to do |format|
      if @unit_size.update_attributes(params[:unit_size])
        format.html { redirect_to @unit_size, notice: 'Unit size was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @unit_size.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_sizes/1
  # DELETE /unit_sizes/1.json
  def destroy
    @unit_size = UnitSize.find(params[:id])
    @unit_size.destroy

    respond_to do |format|
      format.html { redirect_to unit_sizes_url }
      format.json { head :no_content }
    end
  end
end
