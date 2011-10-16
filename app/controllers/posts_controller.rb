class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  #This is a prefilter test to ensure that the user is logged in before any of the operations are performed except searching and displaying all posts.
  before_filter :require_login , :except => [:search, :show,:index]
  def index
    #Calculate the number of votes for each post from the likes table and calculate the metric to reorder the posts while displaying them.
    @posts=Array.new
    @b=Array.new

    @post81 = Post.all
       @post81.each do |post|
         @v=0
         @s2=nil
           @s2=Like.all
                 @s2.each do |s2|
                   if(s2.post_id==post.id)
                  @v=@v+1
                     end

                 end
         puts(@v)
                @b<<[(10+@v-(Date.today-post.created_at.to_date).to_i)*(-1),post.id]

         puts((Date.today-post.created_at.to_date).to_i)
       end
    @b.sort
    @arr=Array.new
    @arr=@b.sort
    puts("arr")
    puts(@arr)
    puts(@b)
       @arr.each do |arr|
         @posts<<Post.find_by_id(arr[1])
       end
         @xxx=Array.new
    @xxx<<5
    @xxx<<1
    @xxx<<2
    puts(@xxx)
    @xxx.sort
    puts(@xxx.sort)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #displaying a particular post and its replies along with the number of likes for each post and its reply.
    @post = Post.find(params[:id])
                     session[:lmad]=@post.id
    @post8=Array.new

    @post80=Post.all
     @post80.each do |post|

       if(post.IDofParent==session[:lmad] && post.IDofParent!=post.id)
         puts(post.content)
         @post8<<post
       end
     end
      @vote=0
     @s=Like.all
            @s.each do |s|
              if(s.post_id==session[:lmad])
                @vote=@vote+1

              end
            end

     puts(@vote)


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        @post.update_attribute("IDofParent",@post.id)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

def reply
  @post=Post.new(:content=>params[:rep],:user_id=>session[:mad],:postName=>nil,:IDofParent=>session[:lmad])
  @post.save
  redirect_to("/posts/#{session[:lmad]}")


end
  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])

        format.html { redirect_to "/posts/#{session[:lmad]}", notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    #When a post is destroyed all its corresponding replies should also be deleted from the database to ensure data integrity.
  @post = Post.find(params[:id])
  session[:countd]=0
   @del_entry=@post.id
  session[:countd]+=1
    @post.destroy
      @remrep=Post.all
                    @remrep.each do |remrep|
                      if(remrep.id!=remrep.IDofParent && remrep.IDofParent==@del_entry)
                        session[:countd]+=1
                        remrep.destroy


                      end
                    end
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

  def search

       @posts=Array.new

      puts(params["name"])
      if(params["name"]=="search by post content")
         @spot=Post.all
    @spot.each do |post|
      reg=Regexp.new('\w*'+params[:l]+'\w*')
      str=post.content

      if(reg.match(str))
        @posts<<post
      end
      end
      else
                     reg=Regexp.new('\w*'+params[:l]+'\w*')
                     @u=User.all

                     @u.each do |user|
                       if(reg.match(user.username))
                                  @b=user.id
                         break
                       end
                     end
      @spot1=Post.all
                     @spot1.each do |post|
                       if(post.user_id==@b)
                         puts("enterinnnnnnnnnnnnnnnnnnnnnnnnng")
                         @posts<<post
                       end
                     end
        end

    end
   if(@posts!=nil)
   @posts.each do |post|
         puts  post.content
   end
   end
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

