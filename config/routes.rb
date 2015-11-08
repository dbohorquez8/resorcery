Rails.application.routes.draw do
  devise_for :users

  get '/demo', to: "guests#show", as: "demo"

  resource :dashboard, only: [:show]

  get '/w/new', to: 'workspaces#new', as: :new_workspace
  get '/w/:wid(/:name)', to: 'workspaces#show', constraints: { wid: /[^\/]+/}, as: :workspace

  api version: 1, module: "api/v1" do
    resources :workspaces, :only => [:create, :index]

    scope '/w/:wid', constraints: { wid: /[^\/]+/} do
      resource :workspace, only: [:show], path: ""
      resources :availabilities, :only => [:show]
      resources :resources, :only => [:create]
      resources :resource_groups, :only => [:create]
      resources :allocations, :only => [:create, :index]
    end
  end

  root to: "pages#index"

  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
end
