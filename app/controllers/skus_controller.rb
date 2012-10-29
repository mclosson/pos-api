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
        #
        #@lines = worksheet.rows.map {|row| row}

        # Remove the first line as it contains column headers
        worksheet.rows.shift

        worksheet.each do |row|
          #description  modelo  color talla(size) upc cantidad(amount)  price category  gender  season
          #BFT0000090  HNV S 886766182491  2 28  FLEECES BOYS  FA12

          description = row[0]
          model = row[1]
          color = row[2]
          size = row[3]
          upc = row[4]
          amount = row[5]
          price = row[6]
          category = row[7]
          gender = row[8]
          season = row[9]
          
          # 0 - this likely goes in the skus table
          # 1 - this not sure yet maybe in the skus table
          # 2 - not sure where this goes (color) I don't see a colors table yet
          UnitSize.create(size: size) unless UnitSize.where(size: size).count > 0
          # 4 - this likely goes in the skus table
          # 5 - this likely goes in the skus table
          # 6 - this I'm not sure what table it goes in yet
          # 7 - this goes in the seasons table which needs to be created
          Gender.create(description: gender) unless Gender.where(description: gender).count > 0
          Season.create(name: season) unless Season.where(name: season).count > 0
        end

      end

    end

    redirect_to skus_url, notice: "SKU's uploaded"
  end
end 
