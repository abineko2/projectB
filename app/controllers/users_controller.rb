class UsersController < ApplicationController
  before_action :log_in_user,only:[:index,:edit,:update]
  before_action :current_user_check,only:[:edit,:update] 
  before_action :find_user,only:[:edit_basic_info,:updateBasicInfo,:show]
  before_action :admin_user,only:[:index,:edit_basic_info,:update2,:destroy,:edit2]
  before_action :page_block,only:[:show]
  before_action :startLogin
  before_action :admin_close,only:[:show,:edit,:update]
  before_action :number_control
  
  
  def index    #一覧
    @users=User.paginate(page:params[:page]).order('created_at asc')
    if request.post?
       @users=@users.where 'name like?','%'+params[:name]+'%'
       
    end    
   
  end
  def import
    User.import(params[:file])
    flash[:success] = "インポートできました"
    redirect_to users_url
  end

  def new      #新規登録ページ
    @user=User.new
  end
  
  def create   #登録
    @user=User.new(user_parameter)
    if @user.save
       login(@user)
      flash[:success]="登録しました"
      redirect_to root_url
    else    
      render :new
    end
  end

  def edit   #編集ページ
  end
  
  def update  #アップデート
    
    if @user.update_attributes(user_parameter)
      flash[:success]="編集しました"
      redirect_to @user
    else
      render :edit
    end  
  end
  def update2 #アップデート2
    @user=User.find(params[:id])
    if @user.update_attributes(user_parameter)
      flash[:success]="編集しました"
      redirect_to users_url
    else
      render :edit2
    end  
  end
  
  def destroy    #ユーザー削除
    User.find(params[:id]).destroy
    redirect_to users_url
  end
  
  def editBasicInfo  #基本情報編集ページ
  end
  
  def updateBasicInfo  #基本情報update
    if @user.update_attributes(basic_info_parameter)
      flash[:info]="編集しました"
      redirect_to @user
    else
      render :editBasicInfo 
    end  
  end  
  
  def show  #勤怠ページ
    @user = User.find(params[:id])
   
    @notice=Notice.find_by(user_id:@user.id) if @user.superior?
    
    
    if params[:first_day].nil?
        @first_day=Date.today.beginning_of_month     
    else
       @first_day=Date.parse(params[:first_day])
    end  
    @last_day=@first_day.end_of_month
  
    unless  @user.sends.any?{|send| send.month==@first_day.to_s(:month)}
       record=@user.sends.build(month:@first_day.to_s(:month))
       record.save
    end
    @send=Send.find_by(month:@first_day.to_s(:month),user_id:@user.id)
    
    (@first_day..@last_day).each do |day|
      unless @user.attendances.any?{|attendance| attendance.worked_on==day}
        record=@user.attendances.build(worked_on:day)
        record.save
      end
      unless  @user.send2s.any?{|send2| send2.worked_on==day}
        record=@user.send2s.build(worked_on:day)
        record.save
      end
       
    end  
  
    @dates=setDate
    @overs=@user.send2s.where('worked_on>=? and worked_on<=?',@first_day,@last_day).order('worked_on asc')
    @count=@dates.where.not(start_at:nil).count+@dates.where.not(new_start:nil).count
    respond_to do |format|
      format.html do
         
      end 
      format.csv do
         send_data render_to_string, filename: "attendance-#{Time.zone.now.strftime('%Y%m%d%S')}.csv", type: :csv
      end
    end  
    if @user.superior?
       @sends=Send.all
   
    end  
    if params[:link].nil?
      @link=true
    else
      @link=params[:link]
    end  
  end
  #======1ヶ月申請モーダル=======
  def box
    @user=User.find(params[:id])
    @sends=Send.where(superior:@user.name) 
    @first_day=params[:date].to_date
     
     array=[]
     @sends.each do |send|
       unless send.conf=="承認" || send.conf=="否認"
         
         array << send.user.name
       end
     end   
     @nameArray=array.uniq
     
  end
  #=======残業申請依頼モーダル用
  def box2
    @send2=Attendance.find(params[:id])
    @user=User.find(params[:user_id])
    @worked_on=params[:date].to_date
    @date=params[:date].to_date.to_s(:date)
    @day=%w(日 月 火 水 木 金 土)[params[:date].to_date.wday]
    
  end
  
  #======1ヶ月申請=============
  def sendcreate
    
    @user=User.find(params[:id])
    if send_parameter[:link]=="true"
        @link=true
    end
    @first_day=params[:date].to_date
    
    @send=Send.find(params[:send_id])
    unless @send.superior==nil
        user=User.find_by(name:@send.superior)
        notice=Notice.find_by(user_id:user.id)
        num=notice.one_month_num-1
        notice.one_month_num=num
        notice.save
    end  
    unless send_parameter[:superior]=="" || send_parameter[:superior]==nil
     
      if @send.conf=="承認" || @send.conf=="否認"
        @send.conf=""
        @send.save
      end 
       if  @send.update_attributes(send_parameter)
          send_num=Send.where(superior:send_parameter[:superior]).where.not(conf:"否認").where.not(conf:"承認").count
        
          @sp=User.find_by(name:send_parameter[:superior])  
          @notice=Notice.find_by(user_id:@sp.id)
          @notice.one_month_num=send_num
        
          @notice.save
          flash[:success] = "所属長申請しました"
          redirect_to user_url(@user,params:{first_day:@first_day})
          
       else
       
       end  
    else  
        flash[:danger] = "上長を選択ください"
        redirect_to user_url(@user,params:{first_day:@first_day})
    end
  end
  
private
  def user_parameter   #form送信時parameter
     params.require(:user).permit(:name,:email,:password,:password_confirmation,:affiliation,:employee_number,:uid,:basic_work_time,:designated_work_start_time,:designated_work_end_time)  
  end
  def send_parameter
    params.require(:send).permit(:superior,:month,:user_id,:conf,:tm,:link)  
  end
  
  def basic_info_parameter
    params.require(:user).permit(:basic_work_time,:designated_work_start_time)
  end
  
  def log_in_user  #ログインしてるかチェック
     unless login?
       save_url 
       flash[:danger] = "ログインしてください"
       redirect_to login_url
     end  
  end
  
  def current_user_check  #ログインユーザーによるアクセスかチェック
     @user=User.find params[:id]
    redirect_to login_url unless current_user?(@user) 
  end
  
  def find_user
     @user=User.find(params[:id])
  end
  def admin_user
    if !current_user.admin? 
      flash[:danger]="管理者以外アクセスできません"
      redirect_to root_path 
    end
  end
  
  def page_block
       @user=User.find(params[:id])
       if login?
         if !current_user.admin? && !current_user.superior?
           redirect_to root_url  unless current_user?(@user)
         end     
       end    
         
  end
   def admin_page_block
       @user=User.find(params[:id])
       if login?
         if !current_user.admin?
           redirect_to root_url  unless current_user?(@user)
         end     
       end    
         
   end
  
  def admin_close
    redirect_to root_url if current_user.admin?
  end
 
end
