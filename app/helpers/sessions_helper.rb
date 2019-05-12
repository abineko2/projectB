module SessionsHelper
    
    def login(user)     #session_idset
        session[:user_id]=user.id
    end
    
    def  cookiesLogin(user)
        cookies.signed[:user_id]={value:user.id,expires: 1.hour.from_now }
    end
    
    def current_user  #ログインユーザー
        if !cookies.signed[:user_id].nil?
             @current_user ||=User.find_by(id:cookies.signed[:user_id])
        else
             @current_user ||=User.find_by(id:session[:user_id])
        end    
       
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
    
    def startLogin
        current_user unless cookies.signed[:user_id]
        login?
    end
end
