class SessionsController < ApplicationController
   before_action :startLogin
   
  def new  #ログインページ
  
  end
  
  def create
    user=User.find_by(email:params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if params[:session][:check].to_i==1
         cookiesLogin(user)
         login(user)
      else
         login(user)
      end  
      
       flash[:success] = "ログインしました"
        redirect_save_url root_url
    else
       flash.now[:danger] = "メールアドレスまたはパスワードが違います"
       render :new
    end  
  end
  
  def destroy
    session.delete(:user_id)
    cookies.delete :user_id
    redirect_to login_url
  end
  

end

