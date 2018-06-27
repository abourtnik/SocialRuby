Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/private'
  resources :posts

  get '/users/show/:id', to: 'users#show'

  get '/posts/like/:id', to: 'posts#like', as: 'like_post'
  get '/posts/unlike/:id', to: 'posts#unlike', as: 'unlike_post'

  get '/users/follow/:id', to: 'users#follow', as: 'follow_user'
  get '/users/unfollow/:id', to: 'users#unfollow', as: 'unfollow_user'
end
