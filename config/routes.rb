Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show] do
    resources :items, only: [:index, :show]
  end

  resources :items do
    resources :drinks, only: [:new, :create]
  end

  resources :drinks, except: [:edit, :update]

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  
  get '/', to: "welcome#home"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
