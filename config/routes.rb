Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  #get "up" => "rails/health#show", as: :rails_health_check

  root "countries#index"
  resources "countries",  only: [:index, :show]
end
