Rails.application.routes.draw do
  root 'charts#index'

  resources :charts
end
