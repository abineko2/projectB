Rails.application.routes.draw do
   resources :bases

  get 'login',to:'sessions#new'
  post 'login',to:'sessions#create'
  delete 'logout',to:'sessions#destroy'
  
  get 'user/:id/edit_basic_info/edit',to:'users#edit_basic_info',as: :basic_info
  patch 'updateBasicInfo',to:'users#updateBasicInfo'

  root 'top_pages#home'
  patch 'users/update2/:id',to:'users#update2',as: :update2
  get 'users/:id/attendances/:date/edit',to:'attendances#edit',as: :edit_attendances
  patch 'users/:id/attendances/:date/update',to:'attendances#update',as: :update_attendances
  get 'logview',to:'attendances#logview'
  
  get 'goToWork',to:'attendances#goToWork'
  get 'baseInfo',to: 'attendances#baseInfo'
  post 'baseInfo',to: 'attendances#basenew'
 
  
   get 'usersearch',to:'users#index'
   post 'usersearch',to:'users#index'
  resources :users do
    resources :attendances,only: :create
    post :import,on: :collection
  end 
end
