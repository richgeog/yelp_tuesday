Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: "restaurants#index"

  resources :users do
    resources :restaurants
  end

  resources :restaurants, shallow: true do
    resources :reviews do
      resources :endorsements
    end
  end
end
