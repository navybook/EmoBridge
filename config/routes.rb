Rails.application.routes.draw do
  get 'help', to: 'static_pages#help'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount ActionCable.server => '/cable'
  resources :password_resets, only: %i[new create edit update]
  get 'tops/index'
  get 'tops/home'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  resources :emotions, only: %i[new create index destroy] do
    get 'partner_index', on: :collection
    resources :likes, only: %i[create destroy]
  end
  resource :mypage, only: %i[show edit update]
  resources :categories
  resources :message_templates
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  resources :invitations, only: %i[new create destroy] do
    post 'generate_unique_id', on: :collection
    patch :approve, on: :member
  end
  resources :emotion_partners, only: %i[destroy]
  resources :notifications, only: %i[index destroy] do
    collection do
      get :unread_count
    end
  end
  post '/', to: 'line_bots#callback'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'tops#index'
end
