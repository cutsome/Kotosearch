Rails.application.routes.draw do
  root to: 'home#index'
  get '/help', to: 'home#help'
  get '/signup_agent', to: 'agents#new'
  post '/signup_agent', to: 'agents#create'
  get '/signup_owner', to: 'owners#new'
  post 'signup_owner', to: 'owners#create'
  resources :agents
  resources :owners
end
