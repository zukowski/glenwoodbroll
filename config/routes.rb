Glenwoodbroll::Application.routes.draw do
  root :to => "videos#index"
  devise_for :users

  resources :videos
  resources :collections, :only => [:index, :create, :update, :destroy] do
    post :populate, :on => :member
    post :switch, :on => :collection
  end
  resources :categories, :except => [:show]
end
