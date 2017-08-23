Rails.application.routes.draw do

  mount StripeEvent::Engine, at: '/stripe/webhooks'

  get 'pages/home'
  get 'pages/admin'
  get 'pages/tees'
  get 'pages/hats'
  get 'pages/jackets'
  get 'pages/accessories'
  get 'pages/subscription'
  get 'pages/about'
  get 'pages/register'

  get 'seller' => "posts#seller"
  get 'sales' => "orders#sales"
  get 'purchases' => "orders#purchases"
  get 'checking' => "brands#checking"
  get 'register' => "pages#register"
  get 'artists' => "brands#index"

  devise_for :users, :controllers => { :registrations => 'users/registrations', :omniauth_callbacks =>"omniauth_callbacks"}


  #root "pages#home"
  #root 'pages#home'
  root 'exhibitions#index'

  resources :posts do
  	put :favorite, on: :member
  	put :like, on: :member

    resources :orders, only: [:new, :create] 

  end

  resources :profiles

  resource :subscription
  resource :card
  resources :addresses

  resources :credits 

  resources :brands


  resources :exhibitions do
      resources :posts
  
  end

  

end
