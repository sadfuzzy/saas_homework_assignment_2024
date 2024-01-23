Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :companies, only: [:index]
    end
  end

  get '*path' => 'home#index', constraints: ->(request) { request.format == :html }

  root to: 'home#index'
end
