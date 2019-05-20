Rails.application.routes.draw do
  # devise_for :users
  root 'top#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get 'users/sign_up2' => 'users/registrations#adress'
    post 'users/sign_up2' => 'users/registrations#adress_create'
    get 'users/sign_up3' => 'users/registrations#credit'
    post 'users/sign_up3' => 'users/registrations#credit_create'
    get 'users/sign_up_fin' => 'users/registrations#fin'
  end
  get 'users/logout', to: 'users#logout'
  resources :users, only: [:show, :edit, :update]
  resources :adresses, only: [:edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
