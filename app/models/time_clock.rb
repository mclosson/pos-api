# class TimeClock

#   def self.clock_in(user, location)
#     EmployeeClockIn.create(clockin_time: Time.now, user, location)
#   end

#   def self.clock_out(user, location)
#     lastclock = EmployeeClockIn.last
#     if lastclock
#       lastclock.clockout_time = Time.now
#       lastclock.save
#     end
#   end

#   def self.hours_worked(user, location, date)
#   end

# end