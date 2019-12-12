Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users
  root to: 'areas#index'

  resources :areas, only: [:index, :show] do
    collection do
      get 'search'
    end
  end
  
  resources :users, only: [:show,:edit,:update] do
    resources :chats,only: [:new,:create]
  end

  resources :blogs

  resource :signups, only: [:create] do
    collection do
      get 'new'
      get 'adviser'
      post 'adviser_create'
      get 'user'
      get 'complete'
    end
  end

  resources :chats, only: [:update] do
    member do
      get 'video'
    end
    
    collection do
      get 'receive'
    end
    resources :voices, only: :create, defaults: { format: 'js' }
    resources :messages, only: [:create]
    resources :chat_reviews, only: [:new,:create]
  end

  namespace :api do
    resources :areas, except: [:index,:new,:destroy,:edit,:create,:show,:update] do
      collection do
        get 'search'
      end
    end 
    resources :messages, except: [:index, :new,:create,:show,:edit,:update,:destroy] do
      collection do
        get 'reload', defaults: { format: 'js' }
      end
    end

    resources :voices, except: [:index, :new,:create,:show,:edit,:update,:destroy] do
      collection do
        get 'reload', defaults: { format: 'js' }
      end
    end
  end
end
