Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: 'login'
    delete 'logout', to: 'devise/sessions#destroy', as: 'logout'
  end

  root 'users#show'

  resources :users, only: [:show, :index]

end
