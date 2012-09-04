class CreateEmployeeClockIns < ActiveRecord::Migration
  def change
    create_table :employee_clock_ins, force: true do |t|
      t.datetime :clockin_datetime
      t.datetime :clockout_datetime
      t.integer :hours_worked
      t.integer :location_id
      t.integer :user_id

      t.timestamps
    end
  end
end