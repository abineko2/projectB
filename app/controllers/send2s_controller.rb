class Send2sController < ApplicationController  #残業申請アクション
  before_action :number_control
  def index
  end

  def content  #残業申請フォーム作成
    
    @superior=User.find_by(name:send2_parameter[:sperior2])
    @notice=Notice.find_by(user_id:@superior.id)
    @user=User.find(params[:user_id])
    @first_day=send2_parameter[:worked_on].to_date.beginning_of_month
    
    num=@notice.over_time_num
    count=Attendance.where(sperior2:@superior.name,answer:"申告中").count
    num=count+1
    @notice.over_time_num=num
    @notice.save
    
    if request.patch?
      @send2=Attendance.find(params[:id])
      
      if send2_parameter[:box2].to_i==1
        date=send2_parameter[:worked_on]
        tomorrow=date.to_date+1
        
        @send2.update_attributes(send2_parameter)
        @send2.time=tomorrow.to_s(:date)
        @send2.worked_on=tomorrow
        @send2.save
        
        send3=Attendance.find(params[:id].to_i+1)
        send3.destroy
        flash[:info] = "申請したのは翌日です"
        redirect_to user_url(@user.id,params:{first_day:@first_day})
      else
        @send2.update_attributes(send2_parameter)
        flash[:success] = "残業申請しました"
        redirect_to user_url(@user.id,params:{first_day:@first_day})
      end
      
      if send2_parameter[:sperior2]==""
        flash[:danger] = "上長を選んでください"
        redirect_to @user
      end  
      
    end  
    
  end
  def box3
    list=Array.new
    @user=User.find(params[:id])
    @first_day=params[:date].to_date
    @send2s=Attendance.where(sperior2:@user.name)
    @send2s.each do |send|
      unless send.answer=="承認"||send.answer=="否認"
       list << send.user.name
      end 
    end 
    p list
    @names=list.uniq
  
  end

  def edit
  end

  def show
  end
  
  def update
    @user=User.find(params[:id])
    @first_day=params[:date].to_date
    parameter.each do |id,item|
       if item[:box3].to_i==1
          send=Attendance.find(id)
          @superior=User.find_by(name:send.sperior2)
       
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
    redirect_to user_url(@user,params:{first_day:@first_day})
  end
private
   def send2_parameter
     params.require(:attendance).permit(:time,:sperior,:sperior2,:worked_on,:overtime,:new_finish2,:box2,:note2,:answer,:user_id)
   end
   def send3_parameter
     params.require(:send2).permit(:time,:sperior,:worked_on,:overtime,:new_finish,:box,:note,:answer,:user_id)
   end
   def parameter
     params.permit(attendances:[:time,:sperior2,:worked_on,:overtime,:new_finish2,:box3,:note2,:answer,:user_id])[:attendances]
   end
end
