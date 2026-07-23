Rails.application.routes.draw do

  root to: 'home#index'
  get 'home', to: 'home#index'
  
  namespace :api do
    scope :"(v1)", module: :v1 do
      resources :news_articles, only: [:index, :show], param: :title
      resources :categories, only: [:index]
      resources :authors, only: [:index]
    end
  end
end
