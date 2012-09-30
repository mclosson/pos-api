class Supplier < ActiveRecord::Base
  attr_accessible :inactive, :margin, :name, :notes, :telephone
end
