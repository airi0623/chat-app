Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root "messages#index"
  #http://localhost:3000/にアクセスした際に表示されるページを指定している 
end
