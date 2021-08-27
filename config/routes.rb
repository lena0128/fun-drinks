Rails.application.routes.draw do

  resources :users, except: [:destroy, :edit, :update] do
    resources :items, only: [:index, :show]
  end

  resources :items, except: [:destroy] do
    resources :drinks, only: [:new, :create]
  end

resources :drinks

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get 'login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
  
  get '/', to: "welcome#home", as: 'home'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
