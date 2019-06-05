class Send2sController < ApplicationController  #残業申請アクション
  def index
  end

  def content  #残業申請フォーム作成
    @user=User.find(params[:id])
    @notice=Notice.find 1
    num=@notice.over_time_num
    if request.post?
      @send2=@user.send2s.new(send2_parameter)
      num+=1
      @notice.over_time_num=num
      @notice.save
      if @send2.save!
        redirect_to root_url
      else  
        
      end  
    end  
    
  end
  def box3
    list=Array.new
    @user=User.find(params[:id])
    @send2s=Send2.where(sperior:@user.name)
    @send2s.each do |send|
       list << send.user.name
    end 
    @names=list.uniq
    p list
    p @names
  end

  def edit
  end

  def show
  end
  
  def update
    @notice=Notice.find 1
    num=@notice.over_time_num
    parameter.each do |id,item|
       if item[:box].to_i==1
          send=Send2.find(id)
          if send.answer=="承認" || send.answer=="否認"
            num-=1
            @notice.over_time_num=num
            @notice.save
          end  
          send.update_attributes(item)
       end    
    end  
    redirect_to root_url
  end
private
   def send2_parameter
     params.require(:send2).permit(:time,:sperior,:worked_on,:overtime,:new_finish,:box,:note,:answer,:user_id)
   end
   def parameter
     params.permit(send2s:[:time,:sperior,:worked_on,:overtime,:new_finish,:box,:note,:answer,:user_id])[:send2s]
   end
end
