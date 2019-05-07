module UsersHelper
    def time_format(time)
        format("%.2f",(time.hour*60+time.min)/60.0)
    end    
end
