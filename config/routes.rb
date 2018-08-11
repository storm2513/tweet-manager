Rails.application.routes.draw do
  root to: 'tweets#index'
  get 'tweets/index'

  get '/auth/twitter/callback', to: 'sessions#create'
  delete 'sessions/destroy'
end
