TweetsApp::Application.routes.draw do
  root to: "sessions#new"

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :tweets, except: [:destroy]
  resources :replies, only: [:create, :destroy]
end
