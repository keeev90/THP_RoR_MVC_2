Rails.application.routes.draw do

  # Specify what Rails should route '/'. The root route only routes GET requests to the action > https://edgeguides.rubyonrails.org/routing.html
  root 'gossip#index' #idem que root to: 'gossip#index'

  # routes dont le controller ne manipule pas de données en base (pas besoin de méthodes CRUD)
  get 'welcome/:user_first_name', to: 'welcome#show'
  get 'team', to: 'team#show'
  get 'contact', to: 'contact#show'

  # routes dont le controller manipule des données en base (méthodes CRUD)
  resources :gossip, only: [:index, :show, :new, :create]
  resources :user, only: [:show]
end

# NB : Rails routes are matched in the order they are specified > https://edgeguides.rubyonrails.org/routing.html
