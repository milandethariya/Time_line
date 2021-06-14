Rails.application.routes.draw do
  resources :activation, only: [:new, :update]
 	patch 'activation/reject'
 	get 'sessions/new'
  post 'sessions/create'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
