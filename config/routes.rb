Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }

  resources :dishes do
    resources :menu_items

    member do
      post 'clone', to: 'dishes#clone'
    end
  end

  get '/menu', to: 'menu_items#index'
  get '*path', to: redirect('/menu')
end
