Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        post :signup, on: :collection
      end
      resources :auth, only: [] do
        post :signin, on: :collection
      end

      get '/content', to: 'contents#index'
      resources :contents, except: %i[index show edit]
    end
  end
end
