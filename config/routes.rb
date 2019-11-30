Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users
  root to: 'chats#video'
  
  resources :chats, except: [:index,:show,:edit,:destroy] do
    member do
      get 'video'
    end
    
    collection do
      get 'receive'
    end
  end
end
