Rails.application.routes.draw do

  devise_for :users
  
  resources :wikis do
    get :privates, on: :collection
    resources :collaborators, only: [:create, :destroy]
  end

  get 'checkouts', to: 'checkouts#index'
  post 'checkouts/charge'
  
  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
