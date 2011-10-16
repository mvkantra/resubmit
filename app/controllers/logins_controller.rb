class LoginsController < ApplicationController
  # GET /logins
  # GET /logins.json
  def index
    #creating a default admin. this gets created, when there is no administrator in the database.
    @admin=User.find_by_utype(1)
    if(@admin==nil)
      l=User.new(:username => "admin",:password=>"admin", :unity_id => "admin",:utype =>1)
      l.save

    end
    render('_form')
  end



  def create

   #in this method, the authentication of the user is done. after the user enters the username and password to login, they are sent as parameters to this method and authentication is done.
    #params[:q] is the username entered and params[:y] is the password entered. session variables are used reference of the user in the Action views and other controllers.
    puts(params[:q])
    @uname = User.find_by_username(params[:q])
     if(@uname==nil)
      flash[:notice] = "Invalid user name"

                 redirect_to(:url=>'/index')

     elsif(@uname.password==params[:y])
       if(@uname.utype==1)
         session[:ad]=@uname.id
       end
       session[:mad] = @uname.id
       @logged_user=User.find_by_id(session[:mad])
        session[:logged]=@logged_user.username

       redirect_to('/posts')
     else
       flash[:notice] = "Invalid password"
      redirect_to(:url=>'/index')
    end

  end


  def logout
    #this method is called when the user clicks on the logout button. the session variables assigned to the user when the user logs in are made equal to null in this method.
    #and a notice is displayed on the screen saying that the user has logged out.
    session[:ad]=nil
    session[:mad] = nil
    flash[:notice12] = "Logged out"
    redirect_to(:controller => :logins, :action => :index)
  end

  def homelog
    #this method is invoked when the user clicks on the Home button. If the user is logged in, they are directed to the home page where all the posts are displayed and if no user is logged in, clicking on the button will take us to the login page.
    #this is the funcitonality implemented in this method.
    if session[:mad] == nil
      redirect_to(:controller => :logins, :action => :index)
    else
      redirect_to(:controller => :posts, :action => :index)
    end
    end
end
