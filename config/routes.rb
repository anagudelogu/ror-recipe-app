Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "public_recipes#index"
  resources :recipes, except: [:update, :edit]
  resources :foods, only: [:index, :new, :create, :destroy]
  get "shopping_list", to: "shopping_list#index"
  get "public_recipes", to: "public_recipes#index"
end
