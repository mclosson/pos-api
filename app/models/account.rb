class Account < ActiveRecord::Base
  attr_accessible :name, :users_attributes
  has_many :locations, :dependent => :destroy
  has_many :users, :dependent => :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :users
end
