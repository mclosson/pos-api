class PaymentType < ActiveRecord::Base
  attr_accessible :description, :location_id
  
  belongs_to :location
  has_many :payments

  def as_json(options = {})
    super(only: [:id, :description])
  end
end
