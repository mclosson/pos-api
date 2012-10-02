class Payment < ActiveRecord::Base
  attr_accessible :amount, :ticket_id, :payment_type_id

  belongs_to :payment_type

  validates :ticket_id, presence: true, numericality: true
  validates :amount, presence: true, numericality: true
  validates :payment_type_id, presence: true, numericality: true
end
