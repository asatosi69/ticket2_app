Rails.application.routes.draw do
  devise_for :sellers
  root 'pages#index'
  get 'pages/show'
end
