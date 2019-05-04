Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  resources :dishes do
    member do
      post 'clone', to: 'dishes#clone'
    end
  end
end
