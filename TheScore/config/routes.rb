Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # handles the API endpoints
  namespace :api, defaults: { format: 'json' } do
    # API is versioned
    namespace :v1 do
      # we only have an index action with available formats CSV and JSON
      resources :players, only: [:index], constraints: { format: /(json|csv)/ }
    end
  end
end
