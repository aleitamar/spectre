Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/', to: 'projects#index'

  resources :projects, param: :slug, only: [:index] do
    resources :suites, param: :slug, only: [:show] do
      resources :runs, param: :sequential_id, only: [:show]
    end
  end

  resources :runs, only: [:new, :create]
  resources :tests, only: [:update, :new, :create]

  get '/baselines/:key', to: 'baselines#show', as: :baseline
end
