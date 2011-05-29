Glenwoodbroll::Application.routes.draw do
  root :to => "videos#index"
  devise_for :users

  resources :videos
  resources :collections, :except => [:new, :edit, :update]
  resources :categories, :except => [:show]
end
