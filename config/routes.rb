Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :themes, :weeks, :cycles
  resources :logs, only: [:create, :update]
  resources :users, only: [:index, :show, :edit, :update] do
    resources :weeks
    resources :years
  end
  resources :years do
    resources :themes
    resources :cycles
  end
  root "dashboard#index"
end
