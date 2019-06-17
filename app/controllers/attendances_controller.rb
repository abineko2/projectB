class AttendancesController < ApplicationController
    before_action :page_block,only:[:edit,:update]
    before_action :startLogin
    before_action :pages_block,only:[:goToWork]
    before_action :number_control
    before_action :admin_close,only:[:edit,:update]
    
    def create       #出退勤時間表示
    
        @user=User.find(params[:user_id])
        @attendance=@user.attendances.find_by(worked_on:Date.today)
        if @attendance.start_at.nil?
            flash[:info]="頑張りましょう"
            @attendance.update_attributes(start_at:current_time)
        elsif @attendance.finished_at.nil?       
             flash[:info]="お疲れ様です"
            @attendance.update_attributes(finished_at:current_time)
        end
        redirect_to @user
    end  
    def edit
        @user=User.find(params[:id])
        if params[:date].nil?
           @first_day=Date.today.beginning_of_month     
        else
           @first_day=Date.parse(params[:date])
        end  
        @last_day=@first_day.end_of_month
        @dates=setDate
    end
    def update
        
        @user=User.find(params[:id])
        
        
        if attendances2_invalid?
            parameter.each do |id,item|
            
                attendance=Attendance.find(id)
                attendance.update_attributes(item)
                
                 
                if (attendance.result=="承認" || attendance.result=="否認"&&!(attendance.new_start==item[:new_start]))
                    attendance.result=""
                    attendance.save
                end 
               
            end
            
            flash[:success]="編集しました"
            redirect_to user_url(@user,params:{first_day:params[:date]})
        else
            flash[:danger]="編集失敗しました"
            redirect_to edit_attendances_path(@user,params[:date])
        end        
    end
    
    def goToWork
       @users=Array.new
       users=User.all
       users.each do |user|
           attends=user.attendances.where("worked_on=?",Date.today) 
           attends.each do |attendance|
               if attendance.start_at.present? && attendance.finished_at.nil?
                   @users << user
               end       
           end       
       end       
    end
    def baseInfo
        
    end
    def logview
        @first_day=Date.parse(params[:date])
        @last_day=@first_day.end_of_month
        @attendance=Attendance.new
        @user=User.find(params[:id])
        @attendances=@user.attendances.where(result:"承認")
        if request.post?
            @attends=@attendances.where(month:params[:month],year:params[:year])
        
        end    

    end
    
    def box
        names=[]
        @user=User.find(params[:id])
        @first_day=params[:date].to_date
        @attendances=Attendance.where(sperior:@user.name)
        @attendances.each do |att|
            if att.result=="申請中" ||att.result=="" || att.result=="なし" || att.result.nil?
              names << att.user.name
            end
        end            
        
        @names=names.uniq
        
    end              #勤怠申請確認
    def confirmation
       @user=User.find(params[:id])   
       @first_day=params[:date].to_date
       notice=Notice.find_by(user_id:@user.id) 
       num=notice.edit_num
       
      parameter.each do |id,item|
          if item[:box].to_i==1
              attendance=Attendance.find(id)
               attendance.update_attributes(item)
              if item[:result]=="承認" || item[:result]=="否認"
                 num-=1
                 notice.edit_num=num
                 notice.save
                
              end
             
          end 
           
      end
      redirect_to user_url(@user,params:{first_day:@first_day})
    end   
    
private
   def parameter
      params.permit(attendances:[:first_day,:worked_on,:center_s,:center_f,:new_start,:new_finish,:box,:note,:sperior,:result,:year,:month])[:attendances] 
   end
   def page_block
       @user=User.find(params[:id])
       if !current_user.admin?
           redirect_to root_url  unless current_user?(@user)
       end       
   end
   def pages_block
       
       if login?
         if !current_user.admin? 
            flash[:danger]="管理者以外アクセスできません"
           redirect_to root_url  
         end     
       end    
   end
  def admin_close
    redirect_to root_url if current_user.admin?
  end
 
    
end
