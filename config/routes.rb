Rails.application.routes.draw do
  resources :workspaces
  root to: "workspaces#index"
end
