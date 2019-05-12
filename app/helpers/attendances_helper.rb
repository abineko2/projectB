module AttendancesHelper
    def setDate
        @user.attendances.where('worked_on>=? and worked_on<=?',@first_day,@last_day)
    end    
    def current_time  #現在時間
        Time.new(
            Time.now.year,
            Time.now.month,
            Time.now.day,
            Time.now.hour,
            Time.now.min,0
        )
    end
    def working_time(finish,start) #在社時間
        format("%.2f",(((finish-start)/60)/60.0))
    end 
    def working_time_sum(total)  #在社時間合計
        format("%.2f",total/60/60.0)
    end    
    
    def attendances_invalid?
        attend=true
        parameter.each do |id,item|
            attendance=Attendance.find(id)
            day=Date.today
            
            if item[:start_at].blank? && item[:finished_at].blank?
                next
            elsif item[:start_at].blank? || item[:finished_at].blank?
               attend=false
               break
            elsif item[:start_at] > item[:finished_at]
                attend=false
                break
            elsif attendance.worked_on>day
                 attend=false
                break        
            end
            
            
        end
        return attend
    end
end
