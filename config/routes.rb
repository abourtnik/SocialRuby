Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'home#index'
  get 'home/private'
  resources :posts

  get '/users/show/:id', to: 'users#show'

  post '/posts/like/:id', to: 'posts#like', as: 'like_post'
  post '/posts/unlike/:id', to: 'posts#unlike', as: 'unlike_post'

  post '/posts/retweet/:id', to: 'posts#retweet', as: 'retweet_post'
  post '/posts/unretweet/:id', to: 'posts#unretweet', as: 'unretweet_post'

  post '/users/follow/:id', to: 'users#follow', as: 'follow_user'
  post '/users/unfollow/:id', to: 'users#unfollow', as: 'unfollow_user'
end
