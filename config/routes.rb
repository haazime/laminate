Rails.application.routes.draw do
  root to: 'pages#index'
  get 'auth/:provider/callback', to: 'oauth_callbacks#create', as: :oauth_callback
  resource :session, only: [:new]
  resources :pages
end
