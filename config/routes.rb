Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  resource :profile, only: [:show, :edit, :update] do
  get :download, on: :member
  end

  root to: redirect("/users/sign_in")

  get "/dashboard", to: "dashboard#index"
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'

  resource :profile, only: [:show, :edit, :update]
end