Rails.application.routes.draw do
  root 'pages#index'
  get 'pages/show'
  
  devise_for :sellers
  resources :sellers, :only => [:index, :update, :destroy]
  resources :tickets, :except => [:show]
  resources :stages, :except => [:show]
  resources :kinds, :except => [:show]
  resources :payments, :except => [:show]
end
