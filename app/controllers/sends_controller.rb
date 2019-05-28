class SendsController < ApplicationController
  
  def update
  
  end
  
  private
    def send_parameter
       params.permit(sends:[:conf])[:sends]
    end
end
