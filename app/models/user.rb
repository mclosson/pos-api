class User < ActiveRecord::Base
  attr_accessible :account_id, :default_location, :email, :employee_id, :enabled, :firstname, :lastname, :password, :shortname, :username
  belongs_to :account
end
