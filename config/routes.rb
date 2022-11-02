Rails.application.routes.draw do
  # sessions
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  post "/signup" => "users#create"

  # profile
  get "/profile" => "users#show"
  patch "/profile" => "users#update"
  delete "/profile" => "users#destroy"

  # categories
  resources :categories, except: %i[ show new edit ]

  # dishes
  resources :dishes, except: %i[ new edit ]

  # tables
  resources :tables, except: %i[ new edit show ]

  # orders

  resources :orders, except: %i[ new edit ]

  # users

  get "/users" => "users#index"

  root "dishes#index"
end
