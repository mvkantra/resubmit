require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not have empty content" do
      a=posts(:noname)
      assert_false a.save
  end
end
