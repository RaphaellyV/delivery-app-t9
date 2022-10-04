Rails.application.routes.draw do
  devise_for :users

  root to: "home#track"
  
  resources :orders, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
  end
end
