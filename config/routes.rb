Rails.application.routes.draw do

  root 'home#top'
  
  devise_for :sellers
  resources :pages
  resources :sellers, :only => [:index, :update, :destroy]
  resources :tickets
  resources :stages, :except => [:show]
  resources :kinds, :except => [:show]
  resources :payments, :except => [:show]
end
