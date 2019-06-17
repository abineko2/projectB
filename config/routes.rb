Rails.application.routes.draw do

  patch 'sends/update/:id/:date',to:'sends#update',as: :sends_update

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
  post 'logview/:id/:date',to:"attendances#logview",as: :logviews
  
  get 'logview/:id/:date',to:'attendances#logview',as: :logview
  get 'data/:val/:val2',to:'attendances#data'
  post 'data',to:'attendances#data'
  
  
  get 'user/attendance/box/:id/:date',to:'attendances#box',as: :user_attendance_box
  get 'users/:id/box2/:date/:user_id',to:'users#box2',as: :over_time
  patch 'user/attendances/confirmation/:id/:date',to:'attendances#confirmation',as: :attendances_confirmation
  patch 'over_time_new/:id/:user_id',to:'send2s#content',as: :over_time_new
  get 'over_time_box3/:id/:date',to:'send2s#box3',as: :over_time_box3
  patch 'over_time_update/:id/:date',to:'send2s#update',as: :over_time_update
  
  get 'goToWork',to:'attendances#goToWork'
  get 'baseInfo',to: 'attendances#baseInfo'
  post 'baseInfo',to: 'attendances#basenew'
  patch 'sendcreate/:id/:date',to:'users#sendcreate',as: :sendcreate
  
   get 'usersearch',to:'users#index'
   post 'usersearch',to:'users#index'
   
   get 'box/:id/:date',to:'users#box',as: :box
   
   
  resources :users do
    resources :attendances,only: :create
    post :import,on: :collection
  end 
end
