class Payment < ActiveRecord::Base
  attr_accessible :amount, :ticket_id

  validates :ticket_id, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
  #validates :type, presence: true, inclusion: { in: %w(cash credit debit check),
  #  message: "%{value} is not a valid payment type" }
end
