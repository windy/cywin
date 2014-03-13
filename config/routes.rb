Eachfund::Application.routes.draw do
  get "activities/show"
  get "projects_searcher/index"
  resources :stars, only: [:create, :destroy]
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
  resources :syndicates
  resources :funds
  resources :jobs, only: [:index]
  resources :projects do
    member do
      get :stage1
      post :stage1
      get :stage2
      post :stage2
      post :publish
      post :invest
      post :invite
      post :close_investment
    end
    resources :members
  end
  resources :investors do
    member do
      get :stage1
      post :stage1
      get :stage2
      post :stage2
    end
  end
  root :to => "home#index"
  #devise_for :users, :controllers => {:registrations => "registrations"}
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "authentications"}
  resources :users do
    collection do
      get :autocomplete
    end
  end
  resources :messages
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
      post :mark_as_deleted
      get  :filter
    end
    collection do
      delete 'destroy_multiple'
    end
  end

  mount ChinaCity::Engine => '/china_city'
end
