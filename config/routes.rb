Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :students, only: [:create, :index, :show] do
        resources :homework_submissions, only: [:create, :index] do
          collection do
            get 'search', to: 'homework_submissions#search'
          end
        end
      end
      
      resources :teachers, only: [:create, :index, :update] do
        resources :homework_reviews, only: [:create, :index, :update] do
          collection do
            get 'search', to: 'homework_reviews#search'
          end
        end
      end

    end
  end
end
