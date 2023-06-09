Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :groups do
    resources :incomes
    # resources :outcomes, except: :show
    resources :outcomes
    resources :memberships
  end
  resources :users

  # resources :outcomes, only: [:show, :destroy]
  resources :outcomes, only: :destroy
  resources :incomes, only: :destroy

end
