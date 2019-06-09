class SendsController < ApplicationController
  
  def update
     send_parameter.each do |id,item|
      if item[:box].to_i==1
         send=Send.find(id)
         @superior=User.find_by(name:send.superior)
         if @superior
             @notice=Notice.find @superior.id
             num=@notice.one_month_num
             
             send.update_attributes(item)
         end
         if send.conf=="承認" || send.conf=="否認"
             num-=1
             @notice.one_month_num=num
             @notice.save
         end     
      end
     end   
     
    redirect_to root_url
  end
  
  private
    def send_parameter
       params.permit(sends:[:conf,:box])[:sends]
    end
end
