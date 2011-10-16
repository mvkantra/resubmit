class ApplicationController < ActionController::Base
  protect_from_forgery

def require_login
# here if the user is not logged in, the user will be directed to index method under logins controller.
#session[:mad] holds the id of the logged in user. if no user is logged in, it is set to nil.
  if(session[:mad]==nil)
  redirect_to(:controller => :logins , :action => :index)
end
end

end
