module ApplicationHelper
    def app_title(page_title="")  #各ページタイトル定義
        default="勤怠システム"
        page_title=="" ? default : page_title+"|#{default}"
    end    
end
