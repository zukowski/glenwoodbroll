Glenwoodbroll::Application.routes.draw do
  root :to => "videos#index"
  devise_for :users

  resources :videos
  resources :collections, :only => [:index, :create, :update, :destroy] do
    member do
      post :populate
      post :depopulate
      get :show_build
      post :build
    end
    post :switch, :on => :collection
  end
  resources :categories, :except => [:show]
end
