class TopPagesController < ApplicationController
   before_action :startLogin
   before_action :add_number
   
  def home  #homeページ対応action
    
  end
  private
    def add_number
        unless Notice.exists?
           @notice=Notice.new
           @notice.save
        end  
    end  
end
