require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  setup do
    @like = likes(:two)
    @post = posts(:personal)
  end

  test "should save if userid is not equal to postid" do
    assert_difference('Like.count',+1) do
    get :index,{'idmine' =>@post.to_param},{:mad=>'21048788'}
    end
  end

  test "should not save if userid is equal to postid" do
       assert_difference('Like.count',0) do
    get :index,{'idmine' => @post.to_param},{:mad=>'210485352'}
    end
  end
end
