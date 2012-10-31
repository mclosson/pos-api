class Supplier < ActiveRecord::Base
  attr_accessible :inactive, :margin, :name, :notes, :telephone

  has_many :skus
end
