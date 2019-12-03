Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users
  root to: 'schools#index'

  resources :schools, only: [:index, :show] do
    collection do
      get 'search'
    end
  end
  
  resources :users, only: [:show] do
    resources :chats,only: [:new,:create]
  end

  resources :blogs

  resource :signups, only: [:create] do
    collection do
      get 'adviser'
      get 'user'
      get 'schedule'
      get 'complete'
      post 'adviser_create'
    end
  end

  resources :chats, only: [:update] do
    member do
      get 'video'
    end
    
    collection do
      get 'receive'
    end
    resources :chat_reviews, only: [:new,:create]
  end
end
