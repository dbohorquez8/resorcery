Rails.application.routes.draw do
  devise_for :users

  resource :dashboard, only: [:show]

  get '/w/new', to: 'workspaces#new', as: :new_workspace
  get '/w/:wid(/:name)', to: 'workspaces#show', constraints: { wid: /[^\/]+/}, as: :workspace

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
