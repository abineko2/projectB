class BasesController < ApplicationController
  def index
    @bases=Base.all
    @base=Base.new
    
  end
  
  def create
     @base=Base.new(base_parameter)
      if @base.save 
           flash[:success]="作成しました"
          redirect_to bases_path
      else
         render :index
      end  
  end  

  def new
  end

  def edit
    @base=Base.find(params[:id])
    
  end
  
  def update
      @base=Base.find(params[:id])
     if @base.update_attributes(base_parameter)
          
          flash[:success]="編集しました"
          redirect_to bases_path
     else
         render :index
     end  
  end  
  
  def show
    
  end
  
  def destroy
    Base.find(params[:id]).destroy
    redirect_to bases_url
  end
private
  def base_parameter
    params.require(:base).permit(:basename,:baseno,:attend)
  end
end
