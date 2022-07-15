Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user', skip: [:omniauth_callbacks], 
  controllers: {
    sessions: 'api/v1/devise_token_auth/sessions'
  #  omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'social_auth/callback', to: 'social_auth#authenticate_social_auth_user' # this is the line where we add our routes
    end
  end

  namespace :admin do
    namespace :v1 do
    end
  end

  namespace :storefront do
    namespace :v1 do
      resources :users
    end
  end
  
end
