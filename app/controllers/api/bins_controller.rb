class API::BinsController < ApplicationController
 
  skip_before_filter  :verify_authenticity_token

  # GET /bins
  def index
    respond_to do |format|
      msg = { :bins => [] }
      format.json { render :json => msg }
    end
  end

  # POST /bins
  def create
    begin
      data = Hash.new
      data["data"] = JSON.parse(request.body.string)
      @bin = Bin.new(data)
      @bin.save
      respond_to do |format|
        format.json { render :json => {:uri => "#{request.original_url}/#{@bin.encode_id}"}, :status => 201}
      end
    rescue JSON::ParserError => e
      respond_to do |format|
        format.json { render :json => {:status => 400, :message => "Bad Request", :more_info => "Invalid JSON"}, :status => 400}
      end
    rescue Exception => e
      respond_to do |format|
        format.json { render :json => {:status => 500, :message => "Internal Server Error", :more_info => e.message }, :status => 500}
      end
    end
  end

  # PUT /bins/:id
  def update
    begin
      #raise "test error"
      data = Hash.new
      data["data"] = JSON.parse(request.body.string)
      id = decode_id 
      @bin = Bin.find(id)
      @bin.update(data)
      respond_to do |format|
        if params.has_key?(:pretty)
          format.json { render :json => JSON.pretty_generate(@bin.data)}
        else
          format.json { render :json => @bin.data}
        end
      end
    rescue JSON::ParserError => e
      respond_to do |format|
        format.json { render :json => {:status => 400, :message => "Bad Request", :more_info => "Invalid JSON"}, :status => 400}
      end
    rescue ActiveRecord::RecordNotFound => e
      respond_to do |format|
        format.json { render :json => {:status => 404, :message => "Not Found"}, :status => 404}
      end
    rescue Exception => e
      respond_to do |format|
        format.json { render :json => {:status => 500, :message => "Internal Server Error", :more_info => e.message }, :status => 500}
      end
    end
  end

  # GET /bins/:id
  def show
    respond_to do |format|
      begin
        id = decode_id 
        @bin = Bin.find(id)
        if params.has_key?(:pretty)
          format.json { render :json => JSON.pretty_generate(@bin.data)}
        else
          format.json { render :json => @bin.data}
        end
      rescue ActiveRecord::RecordNotFound => e
        format.json { render :json => {:status => 404, :message => "Not Found"}, :status => 404}
      rescue Exception => e
        format.json { render :json => {:status => 500, :message => "Internal Server Error", :more_info => e.message }, :status => 500}
      end
    end
  end

  # DELETE /bins/:id
  def destroy
    respond_to do |format|
      # until authentication is in place refuse to fulfill this request
      format.json { render :json => {:status => 403, :message => "Forbidden"}, :status => 403}
      #begin
        #id = decode_id
        #@bin = Bin.find(id).destroy
        #format.json { render :json => {}}
      #rescue ActiveRecord::RecordNotFound => e
        #format.json { render :json => {:status => 404, :message => "Not Found"}, :status => 404}
      #end
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
      #params.require(:bin).permit().tap do |whitelisted|
        #whitelisted[:data] = params[:bin][:data]
      #end
    end

    def decode_id
      #logger.debug "decoding id"
      #logger.debug "#{params[:id]}"
      #logger.debug "#{params[:id].to_i(36)}"
      #logger.debug "#{params[:id].to_i(36).to_s.reverse}"
      #logger.debug "#{params[:id].to_i(36).to_s.reverse.chop}"
      #logger.debug "#{params[:id].to_i(36).to_s.reverse.chop.to_i - 1000}"
      params[:id].to_i(36).to_s.reverse.chop.to_i - 1000
    end

end
