Rails.application.routes.draw do
  root to: "welcome#home"
  
  resources :books
  
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords'
  }
end
