Rails.application.routes.draw do
  resources :genres
  resources :users
  root "movies#index"
  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  get "signup" => "users#new"
  get "signin" => "users#show"
  get "signin" => "sessions#new"
  get "movies/filter/:filter" => "movies#index", as: :filtered

  resource :session, only: [:new, :create, :destroy]


end
