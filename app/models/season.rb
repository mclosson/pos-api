class Season < ActiveRecord::Base
  attr_accessible :close_out, :inactive, :name

  has_many :skus
end