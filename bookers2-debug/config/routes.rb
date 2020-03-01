Rails.application.routes.draw do

  #この記述はuser(resources)に関する記述より上に書こう！！
  devise_for :users

  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  get "home/top"
  get "home/about"
  root to: "home#top"


end
