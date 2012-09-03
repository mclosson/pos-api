class EmployeeClockIn < ActiveRecord::Base
  attr_accessible :clockin_datetime, :clockout_datetime, :hours_worked, :location_id, :user_id
  belongs_to :user
  belongs_to :location
end
