Rails.application.routes.draw do

  root 'home#top'
  
  devise_for :sellers
  resources :pages
  resources :sellers, :only => [:index, :update, :destroy, :mail_all]
  get :sellers, to: 'sellers#mail_all'
  resources :tickets
  resources :stages, :except => [:show]
  resources :kinds, :except => [:show]
  resources :payments, :except => [:show]
  resources :connections, :only => [:index, :update]
  resources :lists, :only => [:index]
  resources :visitors, :only => [:index, :update]
  
  post "registers/create" => "registers#create"
  get "registers/:seller_id/new" => "registers#new", as: :new_registers2
  get "registers/:seller_id/thankyou" => "registers#thankyou", as: :thankyou
  post "registers/:seller_id/new" => "registers#back", as: :new_registers
  post "registers/:seller_id/confirm" => "registers#confirm", as: :confirm_registers
  
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  get '*path', controller: 'application', action: 'render_404'
  

end
