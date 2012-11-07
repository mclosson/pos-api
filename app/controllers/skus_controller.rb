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

      #Spreadsheet.client_encoding = 'UTF-8'
      #workbook = Spreadsheet.open file_path

      #if workbook
      #  worksheet = workbook.worksheet 0

        # Remove the first line as it contains column headers
      #  worksheet.rows.shift

      #  sizes = worksheet.rows.map {|row| row[3]}.uniq
      #  genders = worksheet.rows.map {|row| row[8]}.uniq
      #  seasons = worksheet.rows.map {|row| row[9]}.uniq

        #sizes.each do |size| 
        #  UnitSize.create(size: size) unless UnitSize.where(size: size).count > 0
        #end

        #genders.each do |gender|
        #  Gender.create(description: gender) unless Gender.where(description: gender).count > 0
        #end

        #seasons.each do |season|
        #  Season.create(name: season) unless Season.where(name: season).count > 0
        #end

      #  worksheet.rows.each do |row|
          #amount = row[5]
          #category = row[7]

      location_id = current_user.account.locations.first.id

      csv = open(file_path, 'r')

      csv.lines.first
      sizes = csv.lines.map {|row| row.split(',')[3]}.uniq.select {|size| !size.blank?}
      sizes.each {|size| UnitSize.create(size: size) unless UnitSize.where(size: size).count > 0}

      csv.rewind
      csv.lines.first
      genders = csv.lines.map {|row| row.split(',')[8]}.uniq.select {|gender| !gender.blank?}
      genders.each {|gender| Gender.create(description: gender) unless Gender.where(description: gender).count > 0}

      csv.rewind
      csv.lines.first
      seasons = csv.lines.map {|row| row.split(',')[9]}.uniq.select {|season| !season.blank?}
      seasons.each {|season| Season.create(name: season) unless Season.where(name: season).count > 0}

      csv.rewind
      csv.lines.first
      articles = csv.lines.map {|row| row.split(',')[7]}.uniq.select {|article| !article.blank?}
      articles.each {|article| Article.create(description: article) unless Article.where(description: article).count > 0}

      csv.rewind
      csv.lines.first
      csv.lines.each do |row|
        unless row.include?(',,,,,,,,,')
          sku = row.split(',')[4]
          cost_price = row.split(',')[5]
          category = row.split(',')[7]
          gender = row.split(',')[8]
          description = row.split(',')[0] 
          model = row.split(',')[1] 
          color = row.split(',')[2] 
          sales_price = row.split(',')[6]

          # Lookup article, if not found insert nothing
          articles = Article.where(description: category)
          if articles.count > 0
            article_id = articles.first.id
          else
            article_id = nil
          end
         
          # Lookup article, if not found insert nothing
          genders = Gender.where(description: gender)
          if genders.count > 0
            gender_id = genders.first.id
          else
            gender_id = nil
          end

          if !sku.blank? && !description.blank? && !sales_price.blank?
            if Sku.where(sku: sku).count == 0
              Sku.create(
                sku: sku,
                cost_price: cost_price,
                description: description, 
                model: model, 
                color: color, 
                sales_price: sales_price,
                article_id: article_id,
                gender_id: gender_id,
                location_id: location_id
              )
            end
          end
        end
      end

      redirect_to skus_url, notice: "SKU's uploaded"
    end
  end

end 
