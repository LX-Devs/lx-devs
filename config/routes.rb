Rails.application.routes.draw do


  resources :developers, param: :username

  devise_for :users,
    controllers: { registrations: 'users/registrations' }



  root to: 'pages#home'
  mount Attachinary::Engine => "/attachinary"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
