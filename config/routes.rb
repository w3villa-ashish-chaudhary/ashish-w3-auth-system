Rails.application.routes.draw do
  get "dashboard/index"
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  authenticated :user do
    root to: 'dashboard#index', as: :authenticated_root
  end

  root to: redirect('/users/sign_in')
end