require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  def setup
    @location = locations(:sorna)
  end

  def test_has_many_sales_tickets
    assert_respond_to(@location, :sales_tickets)
    assert_instance_of(Array, @location.sales_tickets)
  end

  def test_has_many_employee_clock_ins
    assert_respond_to(@location, :employee_clock_ins)
    assert_instance_of(Array, @location.employee_clock_ins)
  end    

  def test_belongs_to_account
    assert_respond_to(@location, :account)
    assert_instance_of(Account, @location.account)
  end

end
