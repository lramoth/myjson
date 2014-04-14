class API::BinsController < ApplicationController
 
  skip_before_filter  :verify_authenticity_token

  def index
    # this is just a test for now
    respond_to do |format|
      msg = { :status => "ok" }
      format.json { render :json => msg }
    end
  end

  # GET /bins/:id
  def show
    respond_to do |format|
      begin
        @bin = Bin.find(params[:id]);
        format.json { render :json => {:bin => {:data => @bin.data}} }
      rescue ActiveRecord::RecordNotFound => e
        format.json { render :json => {:error => "404 Not Found"}, :status => 404}
      end
    end
  end

  # POST /bins
  def create
    @bin = Bin.new(bin_params)
    respond_to do |format|
      if @bin.save
        format.json { render :json => {:status => "success", :uri => "#{request.original_url}/#{@bin.id}"}}
      else
        format.json { render json:@bin.errors, status: :unprocessable_entity}
      end
    end
  end

  private
    def bin_params
      #params.require(:bin).permit!
      # Note: since data is json but who's structure is uknown
      # we have no way of whitelisting its attributes
      # Also, we may in the future have parameters we do want to whitelist.
      # This solution came from the following thread: https://github.com/rails/rails/issues/9454
      # where the data attribute is added to the whitelisted set of parameters
      params.require(:bin).permit().tap do |whitelisted|
        whitelisted[:data] = params[:bin][:data]
      end
    end

end
