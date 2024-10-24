Rails.application.routes.draw do
  get "comments/create"
  get "comments/destroy"
  get "posts/index"
  get "posts/show"
  get "posts/new"
  get "posts/create"
  get "posts/edit"
  get "posts/update"
  get "posts/destroy"
  get "sessions/new"
  # Root path
  root 'posts#index'

  # Authentication routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Resourceful routes for posts and comments
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end
