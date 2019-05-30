class SendsController < ApplicationController
  
  def update
    
     send_parameter.each do |id,item|
      if item[:box].to_i==1
         send=Send.find(id)
         send.update_attributes(item)
      end
     end   
     
    redirect_to root_url
  end
  
  private
    def send_parameter
       params.permit(sends:[:conf,:box])[:sends]
    end
end
