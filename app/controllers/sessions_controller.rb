class SessionsController < ApplicationController
  
  def new  #ログインページ
  
  end
  
  def create
    user=User.find_by(email:params[:session][:email])
    if user && user.authenticate(params[:session][:password])
       login(user)
       flash[:success] = "ログインしました"
        redirect_save_url user
    else
       flash.now[:danger] = "メールアドレスまたはパスワードが違います"
       render :new
    end  
  end
  
  def destroy
    session.delete(:user_id)
    redirect_to login_url
  end
  

end

