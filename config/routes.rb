Rails.application.routes.draw do

  root to: "welcome#home"
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  
  resources :users, only: [:index, :show]
  
  resources :books, only: [:index, :new]
  
  resources :recommendations, only: [:new, :create, :edit, :update]
    
  resources :favorites, only: [:create, :destroy]
  
  resources :users do 
    member do 
      get 'favorites'
    end 
  end
end
