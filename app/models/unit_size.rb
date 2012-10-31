class UnitSize < ActiveRecord::Base
  attr_accessible :description, :size

  has_many :skus
end
