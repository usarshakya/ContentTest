Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        post :signup, on: :collection
      end
    end
  end
end
