require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  def setup
    @account = accounts(:ingen)
  end

  def test_has_many_locations
    assert_respond_to(@account, :locations)
    assert_instance_of(Array, @account.locations)
  end

  def test_has_many_users
    assert_respond_to(@account, :users)
    assert_instance_of(Array, @account.users)
  end

end
