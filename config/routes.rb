Rails.application.routes.draw do

  get "activities/show"
  get "projects_searcher/index"
  resources :stars, only: [:create] do 
    collection do
      delete :destroy
    end
  end
  resource :activity, only: [:show]
  resources :about do
    collection do
      get :index
      get :partner
      get :service
      get :law
      get :job
    end
  end
  resources :refine
  resources :categories do
    collection do
      get :autocomplete
    end
  end
  resources :cities do
    collection do
      get :autocomplete
    end
  end
  resources :explore do
    collection do
      get :all
      get :categories
      get :trend
    end
  end
  resources :syndicates
  resources :jobs, only: [:index]
  resources :logos, only: [:create]
  resources :screenshots, only: [:create]
  resources :projects do
    member do
      post :publish
      post :invite
      get :team
      get :invest
      patch :dirty_update
    end
    resources :members do
      collection do
        get :owner
        get :team_story
        post :update_team_story
        get :autocomplete
        post :invite
      end
    end

    resources :person_requires do
    end
  end
  resources :investors do
    member do
      get :stage1
      post :stage1
      get :stage2
      post :stage2
    end
    collection do
      get :autocomplete
    end
  end

  resources :money_requires do
    member do
      post :add_leader
      patch :add_leader
      post :leader_confirm
      patch :leader_confirm
      post :close
      patch :close
      patch :dirty_update
    end
    collection do
      post :dirty_create
      get :dirty_show
      get :opened
      get :history
      get :admin
    end
  end

  resources :messages

  namespace :admin do
    resources :users
    resources :projects
    resources :investors, only: :index do
      member do
      post :accept
      post :reject
      end
    end
    resources :leaders, only: :index do
      collection do
      post :accept
      post :reject
      end
    end
    resources :recommends
    root :to=> "dashboard#index"
  end
  root :to => "home#index"
  resources :home do
    collection do
      get :index
      get :welcome
    end
  end
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "authentications"}
  resources :users, only: [:show] do
    collection do
      get :autocomplete
      post :email_validate
    end

    member do
      get :edit
      get :starred
      get :change_password
    end
  end
  resources :avatars, only: [:create]
  resources :messages
  resources :conversations, only: [:index ] do
    member do
      post :mark_as_read
    end
    collection do
      get :unread_count
    end
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.has_role?(:admin) } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
