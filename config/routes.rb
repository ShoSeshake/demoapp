Rails.application.routes.draw do
  devise_for :users
  root to: 'chats#video'
  resources :chats, except: [:index, :new,:create,:show,:edit,:update,:destroy] do
    collection do
      get 'video'
    end
  end
end
