class User < ActiveRecord::Base
  attr_accessible :account_id, :default_location, :email, :employee_id, :enabled, 
                  :firstname, :lastname, :password, :password_confirmation, :shortname, :username

  belongs_to :account
  has_many :employee_clock_ins

  has_secure_password

  def location_valid?(location_id)
    raise ArgumentError unless location_id
    self.account.locations.where(id: location_id).count == 1
  end

end
