Rails.application.routes.draw do
  get 'users/new'
  
  root 'static_pages#home'
  get '/help', to: 'static_pages#help' #,as:'helf' asでリンク名変更が可能！
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/helf', to: 'static_pages#helf'
  # get 'login',to: 'static_pages#login'
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'
end
