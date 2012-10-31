class Gender < ActiveRecord::Base
  attr_accessible :description
  has_many :skus

  validates :description, presence: true
end
