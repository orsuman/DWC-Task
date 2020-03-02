Rails.application.routes.draw do

  #home_controllerを作って、未ログイン状態からページを飛べるようにした。
  #booksもusersもログインしてからでないと見れない(before_action :authenticate_user!)為、新たに作成した。
  get "home/index"
  get "home/about"

  root to: "home#index"

  devise_for :users

  post   '/favorite/:book_id' => 'favorites#create',   as: 'create'
  delete '/favorite/:book_id' => 'favorites#destroy', as: 'destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #ログアウトするのに設定した(必要無いかもしれない)
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :books do
      resource :book_comments, only: [:create]
  end

  #コメントを削除するにはIDが必要だから分ける？？
  resources :book_comments, only: [:destroy]

  resources :users, only: [:index, :show, :edit, :update]

end
