Rails.application.routes.draw do
 root to: 'roots#root'

 namespace :api do
   resources :fighters, only: [:index, :create,]
 end
end
