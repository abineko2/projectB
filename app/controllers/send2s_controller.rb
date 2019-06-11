class Send2sController < ApplicationController  #残業申請アクション
  before_action :number_control
  def index
  end

  def content  #残業申請フォーム作成
    @user=User.find(params[:id])
    @superior=User.find_by(name:send2_parameter[:sperior])
    @notice=Notice.find_by(user_id:@superior.id)
    
    num=@notice.over_time_num
    if request.post?
      @send2=@user.send2s.new(send2_parameter)
      if send2_parameter[:box].to_i==1
        date=send2_parameter[:worked_on]
        tomorrow=date.to_date+1
        attend=Attendance.find_by(worked_on:tomorrow)
        attend.plans=send2_parameter[:new_finish]
        attend.save
        
        @send2.time=tomorrow.to_s(:date)
        @send2.worked_on=tomorrow
      end
      
      num+=1
      @notice.over_time_num=num
      @notice.save
      if send2_parameter[:sperior]==""
        flash[:danger] = "上長を選んでください"
        redirect_to @user
      else
        
        if @send2.save!
           
           redirect_to root_url
        end  
      end  
      
    end  
    
  end
  def box3
    list=Array.new
    @user=User.find(params[:id])
    @send2s=Send2.where(sperior:@user.name)
    @send2s.each do |send|
      if send.answer=="申請中" || send.answer=="なし" || send.answer==nil
       list << send.user.name
      end 
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
    
    parameter.each do |id,item|
       if item[:box].to_i==1
          send=Send2.find(id)
          @superior=User.find_by(name:send.sperior)
       
          @notice=Notice.find_by(user_id:@superior.id)
          num=@notice.over_time_num
          send.update_attributes(item)
          
          if send.answer=="承認" || send.answer=="否認"
            num-=1
            @notice.over_time_num=num
            @notice.save
          end  
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
