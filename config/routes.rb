Rails.application.routes.draw do
  root 'charts#index'

  resources :charts do
    collection do
      post :slide
      post :filter
    end
  end
end
