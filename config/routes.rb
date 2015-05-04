Rails.application.routes.draw do

  devise_for :users

  resources :wikis
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
