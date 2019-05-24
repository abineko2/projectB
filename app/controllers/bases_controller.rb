class BasesController < ApplicationController
  def index
    @bases=Base.all
   
    if request.post?
      @base=Base.new(base_parameter)
      if @base.save
          redirect_to bases_path
      else
         render :index
      end  
    
    else
      @base=Base.new
    end  
  end

  def new
  end

  def edit
  end
private
  def base_parameter
    params.require(:base).permit(:basename,:baseno,:attend)
  end
end
