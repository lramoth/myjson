class HomeController < ApplicationController

  rescue_from ActionController::ParameterMissing, with: :param_missing

  def index
    #@bins_count = Bin.count + 9999
    @bins_count = 9999
  end

  def create
      begin
        data = Hash.new
        data["data"] = JSON.parse(bin_params)
        @bin = Bin.new(data)
        @bin.save
        respond_to do |format|
          format.html {redirect_to(bin_path(:id => @bin.encode_id), notice: "Your JSON was saved.")}
        end
      rescue JSON::ParserError => e
        #flash.now[:error] = "JSON parse error: #{e}"
        flash.now[:error] = "Error: Your JSON appears to be invalid."
        render :action => 'index'
      end
  end

  def show
    @bin = Bin.find(decode_id)
  end

  private 

    def bin_params
      params.require(:data)
    end

    def decode_id
      params[:id].to_i(36).to_s.reverse.chop.to_i - 1000
    end

    def param_missing
      flash[:error] = "Enter some JSON before saving."
      redirect_to :back
    end

end
