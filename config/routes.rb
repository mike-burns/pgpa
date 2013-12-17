Pgpa::Application.routes.draw do
  root to: 'homes#show'

  resource :session, only: [:new, :destroy] do
    resources :by_keys, only: [:create]
    resources :by_totps, only: [:create]
    resources :by_passphrases, only: [:create]
  end

  resources :users, only: [:new, :index, :show]
  resource :user, only: [] do
    resources :keys, only: [:create]
    resources :totps, only: [:create]
    resources :passphrases, only: [:create]
  end

  resources :completers, only: [:show]
end
