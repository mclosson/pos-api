class PaymentType < ActiveRecord::Base
  attr_accessible :description, :location_id
  
  belongs_to :location
  has_many :payments

  validates :description, presence: true
  validates :location_id, presence: true, numericality: true

  def as_json(options = {})
    super(only: [:id, :description])
  end
end
