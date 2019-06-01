module AttendancesHelper
    def setDate
        @user.attendances.where('worked_on>=? and worked_on<=?',@first_day,@last_day).order('worked_on ASC')
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
    def attendances2_invalid?
        attend=true
        parameter.each do |id,item|
            attendance=Attendance.find(id)
            day=Date.today
            
            if item[:new_start].blank? && item[:new_finish].blank?
                next
            elsif item[:new_start].blank? || item[:new_finish].blank?
               attend=false
               break
            elsif item[:new_start] > item[:new_finish]
                attend=false
                break
            elsif attendance.worked_on>day
                 attend=false
                break        
            end
            
            
        end
        return attend
    end
    def timeChange(min)
        
        num=min.to_i/15
        min2=num.to_i*15
        if min.to_i>min2
            min=min2
        end 
        return min
    end
    def timeCustom(hour,min)
        format("%.2f",(hour*60+min)/60.0)
    end
end
