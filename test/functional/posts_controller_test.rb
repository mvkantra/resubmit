require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  #***************************setup***************************************
  setup do
    @post = posts(:personal)
    @post1 = posts(:college)
    @user=users(:sindhura)
    @user1=users(:ncsu)
  end

  #**********************************index**********************************

  test "should get index with login" do
    get :index,nil,{'username' => @user.username, 'mad' => @user.id}
    assert_response :success
    assert_not_nil assigns(:posts)
  end




  #****************************new*******************************************
  test "should not get new without login" do
    get :new
    assert_redirected_to(:controller => :logins , :action => :index)
  end

  test "should get new with login" do
    puts "yaaaaaaaaaaaaaaayyyyyyyyyyyyyyy"
      get :new,nil,{'username' => @user.username, 'mad' => @user.id}
      assert_response :success
      assert_not_nil assigns(:post)
    end

  #******************************create********************************************
  test "create post with logged in user" do
    assert_difference('Post.count') do
      p=Post.new(:content => 'how r u?', :postName => 'i am fine')
      post :create, {post: p.attributes},{'username' => @user.username, 'mad' => @user.id}
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should not create post without login" do
    post :create, post: @post.attributes
    assert_redirected_to(:controller => :logins , :action => :index)
  end

  #*****************************show************************************
  test "should show post" do
    get :show, {id: @post.to_param}
    assert_response :success
  end

  test "correct count displayed" do
    put :show, {id: @post.to_param}
    assert_equal(3, assigns["vote"])
  end

   test "correct replies displayed" do
      put :show, {id: @post.to_param}
      assert_equal(3,assigns[:post8].length)
    end



#****************************edit**********************************************
  test "should get edit" do
    get :edit, {id: @post.to_param , post: @post.attributes},{'username' => @user.username, 'mad' => @user.id}
    assert_response :success
  end


  test "cannot edit anything if not logged in" do
    get :edit, {id: @post1.to_param , post: @post1.attributes}
       assert_redirected_to(:controller => :logins , :action => :index)
  end

  #*********************************update********************************************

  test "should update post only if user posted it" do
    put :update,{id: @post.to_param , post: @post.attributes},{'username' => @user.username, 'mad' => @user.id}
    assert_equal("Post was successfully updated.",flash[:notice])
  end


  test "cannot post if not logged in" do
    put :update ,{id: @post1.to_param}
         assert_redirected_to(:controller => :logins , :action => :index)
  end

  #***********************************destroy*********************************************

  test "should destroy post if its posted by user" do

      delete :destroy, {id: @post.to_param , post: @post.attributes},{'username' => @user.username, 'mad' => @user.id}
    assert_equal(4,session[:countd])

    assert_redirected_to posts_path
  end


  test "cannot destroy if not logged in" do
      put :destroy ,{id: @post1.to_param}
           assert_redirected_to(:controller => :logins , :action => :index)
    end

  #*******************************search***********************************************

  test "successful search by content" do
    put :search, {'name'=>'search by post content', 'l' => 'hello'}
    assert_not_nil assigns["posts"]
  end

  test "successful search by user" do
      put :search, {'name'=>'search by user', 'l' => 'sindhura'}
      assert_not_nil assigns["posts"]
    end

  test "unsuccessful search by content" do
     put :search, {'name'=>'search by post content', 'l' => 'hghgjkhnkkjnj'}
     assert_equal(Array.new,assigns["posts"])
   end

   test "unsuccessful search by user" do
       put :search, {'name'=>'search by user', 'l' => 'hghgjkhnkkjnj'}
       assert_equal(Array.new,assigns["posts"])
   end

  #********************************reply******************************************
  #test "can reply to any post if logged in" do
   #   assert_difference('Post.count',1) do
    #    put :reply, {'rep' => 'hello hello hello'},{'mad' => @user.id, 'lmad' => @user.id }
     # end
    #end

    test "cannot reply to any post if not logged in" do
      assert_difference('Post.count',0) do
        put :reply,{'rep' => 'hello hello hello'},{'lmad' => @user1.id }
      end
    end


end
