Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  root to: redirect("/users/sign_in")

  get "/dashboard", to: "dashboard#index"
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  resource :profile, only: [:show, :edit, :update] do
    get :download, on: :member
  end

  get '/pricing', to: 'pricing#index', as: :pricing_index
  post '/payments/create', to: 'payments#create', as: :payment_create
  get '/payments/success', to: 'payments#success', as: :payment_success
  get '/payments/cancel', to: 'payments#cancel', as: :payment_cancel
  post '/webhooks/stripe', to: 'payments#webhook', as: :stripe_webhook

  namespace :admin do
    get '/users', to: '/admin#users', as: :users
  end
end