Rails.application.routes.draw do

  root to: "welcome#home"
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
  
  resources :users, only: [:index, :show]
  
  resources :books
  
  resources :users do
    resources :recommendations
  end
end
