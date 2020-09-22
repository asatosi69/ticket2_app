Rails.application.routes.draw do
    
    #constraints subdomain: '' do
    constraints (lambda { |request| request.subdomain.present? }) do

      root 'home#top'
      
      devise_for :sellers, :controllers => {
       :registrations => 'sellers/registrations',
       :passwords => 'sellers/passwords',
       :confirmations => 'sellers/confirmations',
       :sessions => 'sellers/sessions',
       :unlocks => 'sellers/unlocks'
      }
      get '/sellers/sign_out' => 'devise/sessions#destroy'
      
      resources :sellers, :only => [:index, :update, :destroy]
      get "sellers/mail_all" => "sellers#mail_all", as: :mail_all
      
      resources :pages

      get "tickets/download" => "tickets#download"
      resources :tickets
      
      resources :stages, :except => [:show]
      
      resources :kinds, :except => [:show]
      
      resources :payments, :except => [:show]
      
      resources :connections, :only => [:index]
      patch "connections/connection_all" => "connections#connection_all", as: :connection_all
      
      resources :connections2, :only => [:index]
      patch "connections2/connection2_all" => "connections2#connection2_all", as: :connection2_all
      
      resources :connections3, :only => [:index]
      patch "connections3/connection3_all" => "connections3#connection3_all", as: :connection3_all
      
      resources :lists, :only => [:index]
      
      resources :visitors, :only => [:index]
      patch "visitors/visitor" => "visitors#visitor", as: :visitor
      
      resources :reserved_lists, :only => [:index]
      get "reserved_lists/reserved_list_print" => "reserved_lists#reserved_list_print", as: :reserved_list_print
      
      resources :reserved_stubs, :only => [:index]
      get "reserved_stubs/reserved_stub_print" => "reserved_stubs#reserved_stub_print", as: :reserved_stub_print
      
      post "registers/create" => "registers#create"
      get "registers/:seller_id/new" => "registers#new", as: :new_registers2
      get "registers/:seller_id/thankyou" => "registers#thankyou", as: :thankyou
      post "registers/:seller_id/new" => "registers#back", as: :new_registers
      post "registers/:seller_id/confirm" => "registers#confirm", as: :confirm_registers
      
    end
    
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  get '*path', controller: 'application', action: 'render_404'
  

end
