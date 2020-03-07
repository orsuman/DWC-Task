Rails.application.routes.draw do

  #home_controllerを作って、未ログイン状態からページを飛べるようにした。
  #booksもusersもログインしてからでないと見れない(before_action :authenticate_user!)為、新たに作成した。
  get "home/index"
  get "home/about"

  root to: "home#index"

  devise_for :users

  post 'follow/:id' => 'relationships#create', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow' # フォロー外す

  get '/search', to: 'search#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #ログアウトするのに設定した(必要無いかもしれない)
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  #rails routesで何のidが使えるか確認
  #resource"s"とすることで、idを生み出してくれる
  #bookの場合new.htmlないしnew_book_pathは不要のなので除く
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get  :followers, :following
    end
  end

end
