Rails.application.routes.draw do
  get 'albums/index'

  get 'albums/create'

  get 'albums/new'

  get 'albums/show'

  get 'albums/destroy'

  get 'albums/update'

  get 'tracks/index'

  get 'tracks/create'

  get 'tracks/new'

  get 'tracks/show'

  get 'tracks/destroy'

  get 'tracks/update'

  get 'bands/index'

  get 'bands/create'

  get 'bands/new'

  get 'bands/show'

  get 'bands/destroy'

  get 'bands/update'

	resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
 		resources :albums, only: [:new]
	end

 	resources :albums, except: [:new] do
 		resources :tracks, only: [:new]
	end

	resources :tracks, except: [:new]
end
