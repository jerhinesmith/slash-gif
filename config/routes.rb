require 'api_constraints'

Rails.application.routes.draw do
  resources :gifs, only: [:index]

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :gifs, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get 'random'
        end
      end
      resources :tags, only: [:index, :show]
    end
  end
end
