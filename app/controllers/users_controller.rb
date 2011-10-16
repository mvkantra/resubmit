class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  def index
    #this method gets list of all users into an instance variable called @users and this happens only when administrator is logged in. The session[:ad] holds the id of the administrator.

    if(session[:ad]!=nil)
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  #here session[:mad] is the session variable which holds current logged in user id.
    if session[:mad]==nil
      redirect_to(:controller => 'logins',:action => 'homelog')
       else
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
      end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    #here, while creating the user, the default user type(utype) is set to zero.
    @user = User.new
     @user.utype=0
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    # here session[:ad] is the session variable which hols the id of the logged in admin and session[:mad] holds the id of the logged in user.
    # an update can be made only when admin is logged in or if the update is being made on the user that is logged in currently.
    #this is the functionality of this method.
      @user = User.find(params[:id])
     if(session[:ad]!=nil || session[:mad].to_i==@user.id)
      respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
      end
      else
       flash[:notice]="Cannot update information of other user"
       redirect_to(:controller => 'logins',:action => 'homelog')
     end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    #here session[:ad] holds the id of the logged in admin. and the user is destroyed only if the logged in user is admin. That is the functionality of this method.
    if(session[:ad]!=nil)
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
    end
    end
end
