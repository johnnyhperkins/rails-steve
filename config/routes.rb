Rails.application.routes.draw do

  devise_for :users
  root to: "home#index"

  resources :users

  resources :courses do
    member do
      post 'bulk_enroll'
    end
  end

end
