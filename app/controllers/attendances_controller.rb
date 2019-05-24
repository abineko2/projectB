class AttendancesController < ApplicationController
    before_action :page_block,only:[:edit,:update]
    before_action :startLogin
    before_action :pages_block,only:[:goToWork]
    
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
        if attendances_invalid?
            parameter.each do |id,item|
                attendance=Attendance.find(id)
                attendance.update_attributes(item)
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
private
   def parameter
      params.permit(attendances:[:start_at,:finished_at,:note])[:attendances] 
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
           redirect_to root_url  
         end     
       end    
   end
    
end
