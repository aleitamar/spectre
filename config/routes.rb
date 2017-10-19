Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'projects#index'

  resources :projects, param: :slug, only: [:index] do
    resources :suites, param: :slug, only: [:show] do
      resources :runs, param: :sequential_id, only: [:show]
    end
  end

  resources :runs, only: [:new, :create]
  resources :tests, only: [:update, :new, :create]

  get '/baselines/:key', to: 'baselines#show', as: :baseline
  get '/projects/:slug', to: 'projects#show', as: :project

  # Auth0 routes for authentication
  get '/auth/oauth2/callback' => 'auth0#callback'
  get '/auth/failure'         => 'auth0#failure'
end
