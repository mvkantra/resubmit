require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should have all fields" do
    a=User.new
    assert_false a.valid?
  end

  test "dont save passwords below min length" do
  a=users(:ncsu)
  assert_false a.save
  end

  test "dont save passwords above max length" do
    a=users(:sindhura)
    assert_false a.save
    end

  test "username should be unique" do
    a=users(:cndura)
    b=User.new(:username => a.username)
    assert_false b.save
  end
end
