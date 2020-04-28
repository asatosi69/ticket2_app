Rails.application.routes.draw do

  root 'home#top'
  
  devise_for :sellers
  resources :pages
  resources :sellers, :only => [:index, :edit, :update, :destroy]
  resources :tickets
  resources :stages, :except => [:show]
  resources :kinds, :except => [:show]
  resources :payments, :except => [:show]
  
  post "registers/create" => "registers#create"
  get "registers/:seller_id/new" => "registers#new"
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  
  
  
end
