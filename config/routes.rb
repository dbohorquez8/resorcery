Rails.application.routes.draw do
  resources :workspaces

  api version: 1, module: "api/v1" do
    resources :workspaces, :only => [:create, :index]
  end

  root to: "workspaces#index"
end
