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
    def working_time_sum(total)
        format("%.2f",total/60/60.0)
    end    
end
