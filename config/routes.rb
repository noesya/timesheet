Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :themes, :weeks
  resources :users, only: [:index, :show] do
    resources :weeks
  end
  resources :years do
    resources :themes
  end
  get 'log' => 'dashboard#log', as: :log
  root "dashboard#index"
end
