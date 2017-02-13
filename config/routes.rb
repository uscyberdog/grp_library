Rails.application.routes.draw do
  resources :users
  resources :books

	# login form
  get 'login', to: 'sessions#new'

  #check to see if we have a user, then set session[:user_id]
  post 'login',to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  post '/lookup', to: 'books#lookup'

  get '/', to: 'sessions#new'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

