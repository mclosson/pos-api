class User < ActiveRecord::Base
  attr_accessible :account_id, :default_location, :email, :employee_id, :enabled, 
                  :firstname, :lastname, :password, :password_confirmation, :shortname, :username

  belongs_to :account

  has_secure_password
end
