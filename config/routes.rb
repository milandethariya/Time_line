Rails.application.routes.draw do
	resources :microposts, only: [:create, :destroy]
  resources :activation, only: [:new, :update]
 	patch 'reject' => 'activation#reject'
 	root 'sessions#new'
  post 'sessions/create'
  delete 'sessions/destroy'
  resources :users, only:[:new, :create, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
