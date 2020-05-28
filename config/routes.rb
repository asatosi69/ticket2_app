Rails.application.routes.draw do

  root 'home#top'
  
  devise_for :sellers
  resources :pages
  resources :sellers, :only => [:index, :update, :destroy, :mail_all]
  get "sellers/mail_all" => "sellers#mail_all", as: :mail_all
  resources :tickets
  resources :stages, :except => [:show]
  resources :kinds, :except => [:show]
  resources :payments, :except => [:show]
  resources :connections, :only => [:index]
  patch "connections/connection_all" => "connections#connection_all", as: :connection_all
  resources :connections2, :only => [:index]
  patch "connections2/connection_all" => "connections2#connection_all", as: :connection2_all
  resources :connections3, :only => [:index]
  patch "connections3/connection_all" => "connections3#connection_all", as: :connection3_all
  resources :lists, :only => [:index]
  resources :visitors, :only => [:index]
  patch "visitors/visitor" => "visitors#visitor", as: :visitor
  
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
