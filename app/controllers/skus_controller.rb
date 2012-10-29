require 'spreadsheet'

class SkusController < ApplicationController
  before_filter :authorize

  def index
    @locations = current_user.account.locations
    @skus = current_user.account.locations.first.skus
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

  def upload
    @lines = []
    if request.post?

      # uploaded_file is a representation in memory
      uploaded_file = params[:skus]

      # file_path is the path on disk to the temp file generated in /tmp/RackMultipart.... something like that
      file_path = params[:skus].path

      Spreadsheet.client_encoding = 'UTF-8'
      workbook = Spreadsheet.open file_path

      if workbook
        worksheet = workbook.worksheet 0

        # Remove the first line as it contains column headers
        worksheet.rows.shift

        sizes = worksheet.rows.map {|row| row[3]}.uniq
        genders = worksheet.rows.map {|row| row[8]}.uniq
        seasons = worksheet.rows.map {|row| row[9]}.uniq

        sizes.each do |size| 
          UnitSize.create(size: size) unless UnitSize.where(size: size).count > 0
        end

        genders.each do |gender|
          Gender.create(description: gender) unless Gender.where(description: gender).count > 0
        end

        seasons.each do |season|
          Season.create(name: season) unless Season.where(name: season).count > 0
        end

        worksheet.each do |row|
          #amount = row[5]
          #category = row[7]
          
          Sku.create(
            sku: row[4],
            cost_price: row[5],
            description: row[0], 
            model: row[1], 
            color: row[2], 
            sales_price: row[6]
          ) unless Sku.where(description: row[0]).count > 0

        end

      end

      redirect_to skus_url, notice: "SKU's uploaded"
    end
  end

end 
