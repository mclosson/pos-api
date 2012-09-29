class PaymentType < ActiveRecord::Base
  attr_accessible :description, :location_id
  
  belongs_to :location

  def as_json(options = {})
    super(only: [:id, :description])
  end
end
