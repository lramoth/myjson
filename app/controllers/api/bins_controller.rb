class API::BinsController < ApplicationController
 
  skip_before_filter  :verify_authenticity_token
  #after_filter :cors_set_access_control_headers

  # GET /bins
  def index
    respond_to do |format|
      msg = { :bins => [] }
      format.json { render :json => msg }
    end
  end

  # GET /bins/:id
  def show
    respond_to do |format|
      begin
        #logger.debug "decoding id"
        #logger.debug "#{params[:id]}"
        #logger.debug "#{params[:id].to_i(36)}"
        #logger.debug "#{params[:id].to_i(36).to_s.reverse}"
        #logger.debug "#{params[:id].to_i(36).to_s.reverse.chop}"
        #logger.debug "#{params[:id].to_i(36).to_s.reverse.chop.to_i - 1000}"
        id = params[:id].to_i(36).to_s.reverse.chop.to_i - 1000
        @bin = Bin.find(id);
        format.json { render :json => @bin.data}
      rescue ActiveRecord::RecordNotFound => e
        format.json { render :json => {:error => "404 Not Found"}, :status => 404}
      end
    end
  end

  # POST /bins
  def create
    data = Hash.new;
    data["data"] = JSON.parse(request.body.string)
    #logger.debug "request.body.string: #{request.body.string}"
    #logger.debug "data hash: #{data}"
    @bin = Bin.new(data)
    respond_to do |format|
      if @bin.save
        format.json { render :json => {:status => "success", :uri => "#{request.original_url}/#{@bin.encode_id}"}}
      else
        format.json { render json:@bin.errors, status: :unprocessable_entity}
      end
    end
  end

  # CORS preflight handled at nginx level
  #def cors_set_access_control_headers
    #headers['Access-Control-Allow-Origin'] = '*'
    #headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    #headers['Access-Control-Max-Age'] = "1728000"
  #end

  private
    def bin_params
      #params.require(:bin).permit!
      # Note: since data is json but who's structure is uknown
      # we have no way of whitelisting its attributes
      # Also, we may in the future have parameters we do want to whitelist.
      # This solution came from the following thread: https://github.com/rails/rails/issues/9454
      # where the data attribute is added to the whitelisted set of parameters
      #params.require(:bin).permit().tap do |whitelisted|
        #whitelisted[:data] = params[:bin][:data]
      #end
    end

end
