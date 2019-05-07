class UsersController < ApplicationController
  before_action :log_in_user,only:[:index,:edit,:update]
  before_action :current_user_check,only:[:edit,:update,:show] 
  before_action :find_user,only:[:edit_basic_info,:updateBasicInfo,:show]
  
  def index    #一覧
    @users=User.paginate(page:params[:page])
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
  
  def editBasicInfo  #基本情報編集ページ
  end
  
  def updateBasicInfo
    if @user.update_attributes(basic_info_parameter)
      flash[:info]="編集しました"
      redirect_to @user
    else
      render :editBasicInfo 
    end  
  end  
  
  def show
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
end
