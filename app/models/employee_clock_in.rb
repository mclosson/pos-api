class EmployeeClockIn < ActiveRecord::Base
  
  attr_accessible :clockin_datetime, :clockout_datetime, :hours_worked, :location_id, :user_id
  belongs_to :user
  belongs_to :location

  def self.last_clock_in_time
    self.last.clockin_time unless self.last.nil?
  end

end
