class Gender < ActiveRecord::Base
  attr_accessible :description

  has_many :skus
end
