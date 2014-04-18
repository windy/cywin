Eachfund::Application.routes.draw do
  get "dashboard/index"
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
  resources :categories
  resources :explore do
    collection do
      get :all
      get :categories
      get :trend
    end
  end
  resources :syndicates
  resources :funds
  resources :jobs, only: [:index]
  resources :projects do
    member do
      post :publish
      post :invite
      get :team
      get :invest
    end
    resources :members do
      collection do
        get :owner
      end
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

  resources :money_requires, only: [ :new, :update, :create ] do
    member do
      post :add_leader
      patch :add_leader
      post :leader_confirm
      patch :leader_confirm
      post :close
      patch :close
    end
  end

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
  resources :messages
  resources :conversations, only: [:index ] do
    member do
      post :mark_as_read
    end
    collection do
      get :unread_count
    end
  end

  mount ChinaCity::Engine => '/china_city'
end
