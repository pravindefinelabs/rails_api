Rails.application.routes.draw do
  resources :articles, only: [:index, :create, :destroy, :update, :show]
end
