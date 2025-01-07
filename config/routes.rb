Rails.application.routes.draw do
  devise_for :teachers
  authenticated :teacher do
    root to: "teachers#dashboard", as: :authenticated_root
  end

  root to: "teachers#dashboard"

  resources :documents, only: [ :create, :show ]

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
