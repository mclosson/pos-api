

class SkusController < ApplicationController
  before_filter :authorize

require 'spreadsheet'

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
      

      # this next line is throwing an exception due to some kind of parsing/encoding error.... unknown why :(
      #workbook = Spreadsheet::ParseExcel.parse(file_path)

      if workbook
        worksheet = workbook.worksheet 0
        #@lines = worksheet.rows.map {|row| row}
        worksheet.each do |row|
          puts row
        end
        
        # here instead of rendering out @lines to the view in reality once the file parsing works we would
        # actually write the values to the various database tables.... just have to figure out encoding error
      end

    end
  end
end 
