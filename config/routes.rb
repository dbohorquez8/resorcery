Rails.application.routes.draw do
  resources :workspaces

  api version: 1, module: "api/v1" do
    resources :workspaces, :only => [:create, :index]

    scope '(/w/:wid)', constraints: { wid: /[^\/]+/} do
      resources :resources, :only => [:create]
      resources :resource_groups, :only => [:create]
      resources :allocations, :only => [:create]
    end
  end

  root to: "workspaces#index"
end
