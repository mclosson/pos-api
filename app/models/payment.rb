class Payment < ActiveRecord::Base
  attr_accessible :amount, :ticket_id

  validates :ticket_id, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
end
