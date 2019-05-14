class UsersController < ApplicationController
  before_action :log_in_user,only:[:index,:edit,:update]
  before_action :current_user_check,only:[:edit,:update] 
  before_action :find_user,only:[:edit_basic_info,:updateBasicInfo,:show]
  before_action :admin_user,only:[:index]
  before_action :page_block,only:[:show]
  before_action :startLogin
  
  
  def index    #一覧
    @users=User.paginate(page:params[:page])
    if request.post?
       @users=@users.where 'name like?','%'+params[:name]+'%'
       
    end    
   
  end

  def new      #新規登録ページ
    @user=User.new
  end
  
  def create   #登録
    @user=User.new(user_parameter)
    if @user.save
       login(@user)
      flash[:success]="登録しました"
      redirect_to @user
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
    if params[:first_day].nil?
        @first_day=Date.today.beginning_of_month     
    else
       @first_day=Date.parse(params[:first_day])
    end  
    @last_day=@first_day.end_of_month
    (@first_day..@last_day).each do |day|
      unless @user.attendances.any?{|attendance| attendance.worked_on==day}
        record=@user.attendances.build(worked_on:day)
        record.save
      end
    end  
    @dates=setDate
    @count=@dates.where.not(start_at:nil).count
  end
  
private
  def user_parameter   #form送信時parameter
     params.require(:user).permit(:name,:email,:password,:password_confirmation,:belongs)  
  end
  
  def basic_info_parameter
    params.require(:user).permit(:basic_time,:appoint_time)
  end
  
  def log_in_user  #ログインしてるかチェック
     unless login?
       save_url 
       flash[:dangert] = "ログインしてください"
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
         if !current_user.admin? 
           redirect_to root_url  unless current_user?(@user)
         end     
       end    
         
  end
end
