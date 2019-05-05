Rails.application.routes.draw do

  devise_for :users, path_names: {
    sign_in: 'login', 
    sign_out: 'logout'
  }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: 'login'
    delete 'logout', to: 'devise/sessions#destroy', as: 'logout'

    authenticated :user do
      root 'users#show', as: :authenticated_root
    end

    unauthenticated :user do
      root 'devise/sessions#new'
    end
  end

  resources :users, only: [:show, :index]

end
