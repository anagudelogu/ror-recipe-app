Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "public_recipes#index"
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, except: [:update, :edit] do
    resources :recipe_foods, only: [:new, :create, :destroy]
  end
  get "shopping_list", to: "shopping_list#index"
  get "public_recipes", to: "public_recipes#index"
end
