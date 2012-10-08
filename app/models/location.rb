class Location < ActiveRecord::Base
  attr_accessible :account_id, :active, :address1, :address2, :city, :description, :direct_distribution, :fax, :overwrite_cost_price, :overwrite_sales_price, :overwrite_season, :phone, :province, :round_sales_price, :short_description, :zipcode
  belongs_to :account  
  has_many :sales_tickets, :dependent => :destroy
  has_many :employee_clock_ins
  has_many :api_keys, :dependent => :destroy
  has_many :payment_types, :dependent => :destroy
  has_many :users, :foreign_key => :default_location
  has_many :skus, :dependent => :destroy

  validates :account_id, presence: true, numericality: true
  validates :description, presence: true
  validates :address1, presence: true
  validates :city, presence: true

  def as_json(options = {})
    super(only: [:id, :description])
  end
end
