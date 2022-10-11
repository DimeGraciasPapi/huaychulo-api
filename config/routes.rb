Rails.application.routes.draw do
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :categories, except: %i[ show new edit ]
end
