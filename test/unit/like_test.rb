require 'test_helper'

class LikeTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end
   test "uniqueness of user for a particular post id" do
  a=likes(:three)
    assert_true a.save
  b=Like.new(:user_id=>'2', :post_id =>'831155591')
    assert_false b.save
  end
end
