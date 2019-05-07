module AttendancesHelper
    def setDate
        @user.attendances.where('worked_on>=? and worked_on<=?',@first_day,@last_day)
    end    
end
