class API::HomeController < ApplicationController
  
  def index
    respond_to do |format|
      format.text { render :text => "Welcome to the myJSON api." }
    end
  end

end
