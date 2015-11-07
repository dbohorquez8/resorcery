Rails.application.routes.draw do
  devise_for :users

  resource :dashboard, only: [:show]

  scope '/w/:wid', constraints: { wid: /[^\/]+/} do
    resource :workspaces, :only => [:show], path: "(:name)"
  end

  api version: 1, module: "api/v1" do
    resources :workspaces, :only => [:create, :index]

    scope '/w/:wid', constraints: { wid: /[^\/]+/} do
      resources :resources, :only => [:create]
      resources :resource_groups, :only => [:create]
      resources :allocations, :only => [:create]
    end
  end

  root to: "pages#index"
end
