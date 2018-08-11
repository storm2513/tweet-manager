Rails.application.routes.draw do
  root to: 'tweets#index'
  get 'tweets', to: 'tweets#index'
  post 'tweets', to: 'tweets#create'
  delete 'tweets/:id', to: 'tweets#destroy', as: 'delete_tweet'

  get '/auth/twitter/callback', to: 'sessions#create'
  delete 'sessions/destroy'
end
