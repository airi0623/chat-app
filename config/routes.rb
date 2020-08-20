Rails.application.routes.draw do
  devise_for :users
  root "rooms#index"
  #http://localhost:3000/にアクセスした際に表示されるページを指定している
  resources :users, only: [:edit, :update]
  #ユーザー編集に必要なルーティングは、editとupdate
  resources :rooms, onlt: [:new, :create]
end
