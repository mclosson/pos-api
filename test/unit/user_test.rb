require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    # This instanciates an ActiveRecord object of the user identified by :matt
    # from the fixtures/users.yml file, it is run before each test is called
    @user = users(:matt)
  end

  def test_belongs_to_account
    assert_respond_to(@user, :account)
    assert_instance_of(Account, @user.account)
  end

  def test_has_many_employee_clock_ins
    assert_respond_to(@user, :employee_clock_ins)
    assert_instance_of(Array, @user.employee_clock_ins)
  end

  def test_locationvalid_no_arguments
    assert_raise(ArgumentError) { @user.location_valid?(nil) }
  end

  def test_locationvalid_good_location
    location = locations(:sorna)
    assert_equal(true, @user.location_valid?(location))
  end

  def test_locationvalid_bad_location
    location = locations(:area51)
    assert_equal(false, @user.location_valid?(location))
  end

end
