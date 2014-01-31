Eachfund::Application.routes.draw do
  get "projects_searcher/index"
  resources :about do
    collection do
      get :index
      get :partner
      get :service
      get :law
      get :job
    end
  end
  resources :projects do
    member do
      get :stage1
      post :stage1
      get :stage2
      post :stage2
    end
    collection do
      get :stage1
      post :stage1
      get :stage2
      post :stage2
    end
  end
  root :to => "home#index"
  #devise_for :users, :controllers => {:registrations => "registrations"}
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "authentications"}
  resources :users
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
