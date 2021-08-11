Rails.application.routes.draw do
  resources :transactions
  resources :categories
  resources :invitations
  get 'admin', to: "admin#index"
  get 'account', to: "account#index"

  devise_for :users, path_names: {sign_in: 'sign-in', sign_up: 'register', sign_out: 'logout'},
             controllers: {registrations: 'registrations'}

  root to: "home#index"

  namespace :api do
    namespace :v1, format: :json do

      resources :transactions

      devise_scope :user do
        post 'login', to: 'sessions#create'
        get 'logout', to: 'sessions#destroy'
      end

    end
  end
end
