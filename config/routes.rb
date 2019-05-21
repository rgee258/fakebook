Rails.application.routes.draw do

  get 'comments/new'
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'friend_requests/show'
  devise_for :users, path_names: {
    sign_in: 'login', 
    sign_out: 'logout'
  }

=begin
  # Uncomment to add omniauth 
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }
=end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: 'login'
    delete 'logout', to: 'devise/sessions#destroy', as: 'logout'

    authenticated :user do
      root 'users#home', as: :authenticated_root
    end

    unauthenticated :user do
      root 'devise/sessions#new'
    end
  end

  get 'users/:id/notifications' => 'users#notifications', as: 'user_notifications'
  get 'users/home'

  resources :users, only: [:show, :index]
  resources :friend_requests, only: [:show, :create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :posts, only: [:show, :index, :new, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:new, :create, :destroy]

end
