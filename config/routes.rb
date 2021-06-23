Rails.application.routes.draw do

  get '/404', to: "errors#not_found"
  resources :friendship, only: [:create, :update, :destroy, :show]
  resources :friendship do
    member do
      get 'receive'
    end
  end
	#resources :microposts, only: [:create, :destroy]
  resources :activation, only: [:index]
  patch 'approve' => 'activation#approve'
 	patch 'reject' => 'activation#reject'
  get 'activation/approvelist'
  get 'activation/rejectlist'
 	root 'sessions#new'
  post 'sessions/create'
  delete 'sessions/destroy'
  #resources :users, only:[:new,:index, :create, :show, :edit, :update, :destroy]
  resources :users do
    member do
      get 'timeline' => 'users#timeline'
    end
  end
  resources :microposts do
    member do
      get 'likes/likeshow'
      get 'likes/unlikeshow'
      patch 'likes/like'
      patch 'likes/unlike'
  		get 'comments/show'
  		post 'comments/create'
  		delete 'comments/destroy'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
