class Account < ActiveRecord::Base
  attr_accessible :name
  has_many :locations, :dependent => :destroy
  has_many :users, :dependent => :destroy
end
