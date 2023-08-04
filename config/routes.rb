Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  resources :foods, only: [:index, :new, :create, :destroy]

  resources :recipes, only: [:index, :show, :new, :create, :destroy, :update] do
    resources :recipe_foods, only: [:new, :create, :destroy, :edit, :update]

  end

  resources :public_recipes, only: [:index]
  get 'shopping_list/index', to: 'shopping_list#index', as: :shopping_list_index
  get 'explore', to: 'explore#index', as: 'explore'

end
