Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :themes, :weeks, :years
  resources :users, only: [:index, :show]
  get 'log' => 'dashboard#log', as: :log
  root "dashboard#index"
end
