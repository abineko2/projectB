class UsersController < ApplicationController
  
  def index    #一覧
    @users=User.all
  end

  def new      #新規登録ページ
    @user=User.new
  end
  
  def create   #登録
    @user=User.new(user_parameter)
    if @user.save
      flash[:success]="登録しました"
      redirect_to @user
    else    
      flash[:danger]="登録失敗"
      render :new
    end
  end

  def edit   #編集ページ
    @user=User.find params[:id]
  end
  
  def update  #アップデート
    @user=User.find params[:id]
    if @user.update_attributes(user_parameter)
      flash[:success]="編集しました"
      redirect_to @user
    else
      flash[:danger]="編集失敗"
      render :edit
    end  
  end

  def show
  end
  
private
  def user_parameter
     params.require(:user).permit(:name,:email,:password,:password_confirmation)  
  end
end
