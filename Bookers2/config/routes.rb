Rails.application.routes.draw do

  #home_controllerを作って、未ログイン状態からページを飛べるようにした。
  #booksもusersもログインしてからでないと見れない(before_action :authenticate_user!)為、新たに作成した。
  get "home/index"
  get "home/about"

  root to: "home#index"

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #ログアウトするのに設定した(必要無いかもしれない)
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :books

  resources :users, only: [:index, :show, :edit, :update]

end
