module UsersHelper
    def time_format(time)
        format("%.2f",(time.hour*60+time.min)/60.0)
    end    
    def supeiors
        @sp_list=Array.new
        members=User.where(superior:true)
        @sp_list << ""
        members.each do |member|
            @sp_list << member.name
        end    
        return @sp_list
    end 
    def list_answer
        @ans_list=["申請中","承認","否認","なし"]
    end
    def over_calc(tm,tm2)
         format("%.2f",(tm.hour*60+tm.min-tm2.hour*60+tm2.min)/60.0)
    end
end
