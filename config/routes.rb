Glenwoodbroll::Application.routes.draw do
  root :to => "videos#index"
  devise_for :users

  resources :videos
  resources :collections, :only => [:index, :create, :destroy] do
    post :populate, :on => :member
  end
  resources :categories, :except => [:show]
end
