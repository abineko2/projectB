Rails.application.routes.draw do
  get 'login',to:'sessions#new'
  post 'login',to:'sessions#create'
  delete 'logout',to:'sessions#destroy'
  
  get 'user/:id/edit_basic_info/edit',to:'users#edit_basic_info',as: :basic_info
  patch 'updateBasicInfo',to:'users#updateBasicInfo'

  root 'top_pages#home'
  resources :users do
    resources :attendances,only: :create
  end 
end
