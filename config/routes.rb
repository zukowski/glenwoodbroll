Glenwoodbroll::Application.routes.draw do
  root :to => "videos#index"
  devise_for :users

  resources :videos
  resources :video_collections, :except => [:new, :edit, :update]
end
