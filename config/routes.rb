Rails.application.routes.draw do
  devise_for :teachers
  authenticated :teacher do
    root to: "teachers#dashboard", as: :authenticated_root
  end

  root to: "teachers#dashboard"

  resources :documents, only: [ :create, :show ]
  get "share/:slug", to: "documents#share_document", as: :share_document

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
