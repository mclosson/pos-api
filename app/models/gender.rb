class Gender < ActiveRecord::Base
  attr_accessible :description
  has_many :skus
  belongs_to :account

  validates :description, presence: true
end
