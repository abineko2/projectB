module UsersHelper
    def time_format(time)
        format("%.2f",(time.hour*60+time.min)/60.0)
    end    
    def supeiors
        @sp_list=Array.new
        members=User.where(superior:true)
        
        @sp_list << ""
        members.each do |member|
            unless current_user?(member)
              @sp_list << member.name
            end
        end    
        return @sp_list
    end 
    def list_answer
        @ans_list=["申請中","承認","否認","なし"]
    end
    def over_calc(tm,tm2)
         format("%.2f",(tm.hour*60+tm.min-tm2.hour*60+tm2.min)/60.0)
    end
    def number_control
        @notices=Notice.all
        @notices.each do |notice|
            if notice.one_month_num<0
                notice.one_month_num=0
                notice.save
            end
        #=============================
            if notice.edit_num<0
                notice.edit_num=0
                notice.save
            end 
        #=============================
            if notice.over_time_num<0
                notice.over_time_num=0
                notice.save
            end    
        end        
    end        
end
