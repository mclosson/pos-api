class Location < ActiveRecord::Base
  attr_accessible :account_id, :active, :address1, :address2, :city, :description, :direct_distribution, :fax, :overwrite_cost_price, :overwrite_sales_price, :overwrite_season, :phone, :province, :round_sales_price, :short_description, :zipcode
  belongs_to :account  
end