Rails.application.routes.draw do
  # devise_for :users
  root 'top#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  devise_scope :user do
    get 'users/sign_up2' => 'users/registrations#new2'
    post 'users/sign_up2' => 'users/registrations#create2'
    get 'users/sign_up3' => 'users/registrations#new3'
    post 'users/sign_up3' => 'users/registrations#create3'
    get 'users/sign_up_fin' => 'users/registrations#fin'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
