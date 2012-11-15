class Article < ActiveRecord::Base
  attr_accessible :description, :inactive, :notes

  has_many :skus
  belongs_to :account
end
