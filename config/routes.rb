Rolodecks::Application.routes.draw do
  root :to => 'contacts#index'
  resources :contacts
  resources :sessions, only: [:create]
  resources :connections, only: [:create]
end
