Rails.application.routes.draw do
  get "pages/privacy"
  get "pages/terms"
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  root to: redirect("/users/sign_in")

  get "/dashboard", to: "dashboard#index"
end
