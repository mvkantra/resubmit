require 'test_helper'

class LoginsControllerTest < ActionController::TestCase
  setup do
    @login = users(:cndura)
  end

   test "should get index" do
    get :index
    assert_response :success
   end

  test "render login screen" do
    get :index
    assert_tag(:tag => 'div')
    assert_tag(:tag => 'p')
    assert_tag(:tag => 'p')
    assert_tag(:tag => 'p')
  end

  test "user password doesnt match" do
  put :create, {'q' => @login.username, 'y' => 'abcdef'}
    assert_redirected_to(:url=>'/index')
  end

  test "user password matches" do
    put :create, {'q' => @login.username, 'y' => @login.password}
      assert_redirected_to('/posts')
  end

  test "user not present in database" do
    put :create, {'q' => 'notfound', 'y' => 'nopwd'}
      assert_redirected_to(:url=>'/index')
  end

   test "invalid username flash" do
      put :create, {'q' => 'notfound', 'y' => 'nopwd'}
      assert_equal "Invalid user name", flash[:notice]
   end

  test "should logout" do
    get :logout
    assert_equal("Logged out",flash[:notice12])
    assert_redirected_to(:controller => :logins, :action => :index)
  end

  test "should go to login home when logged out" do
    get :homelog,nil,{'mad'=> nil}
    assert_redirected_to(:controller => :logins, :action => :index)
  end


  test "should go to posts home when logged in" do
    get :homelog,nil, {'mad'=> @login.id}
    assert_redirected_to(:controller => :posts, :action => :index)
  end

end
