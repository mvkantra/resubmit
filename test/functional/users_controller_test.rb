require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @user = users(:cndura)
    @user1=users(:admin)
    @user2=users(:mvkantra)
  end
 #*******************************index***************************************
  test "should get index only if logged in and is admin" do
    get :index,nil,{'mad'=>@user1.id,'ad'=>@user1.id}
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should not get index if logged in and is not admin" do
      get :index,nil,:mad=> @user.id
      assert_response :success
    assert_nil assigns(:users)
    end

  #****************************new**************************************
  test "should get new if admin" do
    get :new,nil,{'mad'=>@user1.id,'ad'=>@user1.id}
    assert_response :success
  end

  test "should not get new if user" do
      get :new,:mad=>@user.id
    assert_response :success
  end

  #******************************create*********************************
  test "should create user if admin" do
    assert_difference('User.count',1) do
      post :create, {user: {:username=>'achyuth',:password=>'abcdefgh',:unity_id=>'arbukkap'}},{'mad'=>@user1.id,'ad'=>@user1.id}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should create user if user" do
      assert_difference('User.count',1) do
        post :create, user: {:username=>'achyuth1',:password=>'abcdefgh1',:unity_id=>'arbukkap1'}
      end
  end

  #****************************show***********************************************

  test "should show user if admin" do
    get :show, {id: @user.to_param},{'mad'=>@user1.id,'ad'=>@user1.id}
    assert_response :success
  end

  test "should show user if its user and himself" do
      get :show, {id: @user.to_param},{'mad'=>@user.id}
      assert_response :success
    end

  test "should not show user if its user and its not himself" do
      get :show, {id: @user.to_param},{'mad'=>@user1.id}
      assert_nil assigns[:users]
    end



#********************************update*******************************************
    test "should update user if admin" do
    put :update, {id: @user.to_param},{'mad'=>@user1.id,'ad'=>@user1.id}
    assert_equal("User was successfully updated.",flash[:notice])
  end

  test "should update user if its user and himself" do
      put :update, {id: @user.to_param},{'mad'=>@user.id}
     assert_equal("User was successfully updated.",flash[:notice])
    end

  test "should not update user if its user and its not himself" do
      put :update, {id: @user.to_param},{'mad'=>831155591}
          assert_equal("Cannot update information of other user",flash[:notice])
    end

  #*************************destroy*************************************
  test "should destroy user if admin" do
    assert_difference('User.count', -1) do
      delete :destroy, {id: @user.to_param},{'mad'=>@user1.id,'ad'=>@user1.id}
    end

    assert_redirected_to users_path
  end


  #****************************routing**********************************
 test "routes" do
  assert_routing "posts/search", {:controller => 'posts', :action => 'search'}
end



end
