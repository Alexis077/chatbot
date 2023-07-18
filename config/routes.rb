Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get "reports/:id/:report_type", to: "reports#show", as: :reports
  resource :intentions, only: %i[create]
end
