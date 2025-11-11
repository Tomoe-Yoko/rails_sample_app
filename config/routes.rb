Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  
  root 'static_pages#home'
  get '/help', to: 'static_pages#help' #,as:'helf' asでリンク名変更が可能！
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/helf', to: 'static_pages#helf'
  get '/signup',to: 'users#new'
  get '/login',to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
 resources :users
end
