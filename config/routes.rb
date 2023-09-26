Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :students, only: [:create, :index] do
        collection do
          get 'search', to: 'students#search'
        end
      end
      resources :teachers, only: [:index, :update] do
        collection do
          get 'search', to: 'teachers#search'
        end
      end
    end
  end
end
