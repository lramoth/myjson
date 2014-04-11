class API::ObjectsController < ApplicationController

  def index
    # this is just a test for now
    respond_to do |format|
      msg = { :status => "ok" }
      format.json { render :json => msg }
    end
  end

end
