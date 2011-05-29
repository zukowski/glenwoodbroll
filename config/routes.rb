Glenwoodbroll::Application.routes.draw do
  root :to => "videos#index"
  devise_for :users

  resources :videos
  resources :collections, :only => [:index, :create, :destroy]
  resources :categories, :except => [:show]
end
