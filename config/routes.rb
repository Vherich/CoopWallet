Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :groups do
    resources :incomes
    resources :outcomes, except: :show
  end
  resources :users do
    resources :memberships
  end
  resources :outcomes, only: :show
  # Defines the root path route ("/")
  # root "articles#index"
end
