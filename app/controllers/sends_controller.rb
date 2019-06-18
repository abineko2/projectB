class SendsController < ApplicationController
  before_action :number_control
  def update
      @user=User.find(params[:id])
      @first_day=params[:date].to_date
     send_parameter.each do |id,item|
      if item[:box].to_i==1
         send=Send.find(id)
         @notice=Notice.find_by(user_id:@user.id)
         num=@notice.one_month_num
         send.update_attributes(item)
        
         if send.conf=="承認" || send.conf=="否認"
             num-=1
             @notice.one_month_num=num
             @notice.save
         end     
      end
     end   
     
    redirect_to user_url(@user,params:{first_day:@first_day})
  end
  
  private
    def send_parameter
       params.permit(sends:[:conf,:box])[:sends]
    end
end
