class Article < ActiveRecord::Base
  attr_accessible :description, :inactive, :notes
end
