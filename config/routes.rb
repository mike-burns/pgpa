Pgpa::Application.routes.draw do
  root to: 'homes#show'
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :index, :show]
  resources :completers, only: [:show]
end
