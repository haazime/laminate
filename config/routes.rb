Rails.application.routes.draw do
  root to: 'projects#index'

  get 'auth/:provider/callback', to: 'oauth_callbacks#create', as: :oauth_callback
  resource :session, only: [:new]

  #TODO: remove
  resources :pages
end
