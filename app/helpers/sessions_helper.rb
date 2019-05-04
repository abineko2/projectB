module SessionsHelper
    
    def login(user)     #session_idset
        session[:user_id]=user.id
    end
    
    def current_user  #ログインユーザー
        @current_user ||=User.find_by(id:session[:user_id])
    end
    
    def current_user?(user)  #current_userと表示ユーザーが一致するか？
       user==current_user    
    end
    
    def login?  #ログインしてるか？
        !current_user.nil?
    end
    
    def redirect_save_url(default)
        redirect_to(session[:url] || default)
        session.delete(:url)
    end
    
    
    def save_url #ログインチェックで弾かれたurl記録
    
        session[:url]=request.original_url if request.get?
    end        
    
    
end
