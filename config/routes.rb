Rails.application.routes.draw do
  
  resources :drinks, except: [:edit, :update]
  resources :items
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
