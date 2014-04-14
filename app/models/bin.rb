class Bin < ActiveRecord::Base

  def encode_id
    rand = (1+rand(8)).to_s
    id = (self.id + 1000).to_s
    
    #logger.debug "enconding id"
    #logger.debug "#{self.id}"
    #logger.debug "#{id}"
    #logger.debug "#{(id + rand)}"
    #logger.debug "#{(id + rand).reverse}"
    #logger.debug "#{(id + rand).reverse.to_i.to_s(36)}"

    (id + rand).reverse.to_i.to_s(36)
  end

end
