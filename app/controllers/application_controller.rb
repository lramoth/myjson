class ApplicationController < ActionController::Base

  #before_filter :set_no_cache
  #def set_no_cache
  #  response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  #  response.headers["Pragma"] = "no-cache"
  #  response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  #end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end
