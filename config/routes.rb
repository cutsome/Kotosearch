Rails.application.routes.draw do
  root to: 'home#index'
  get '/help', to: 'home#help'
  get '/signup_agent', to: 'agents#new'
  get '/signup_owner', to: 'owners#new'
  get '/login_agent', to: 'agent_sessions#new'
  get '/login_owner', to: 'owner_sessions#new'
  post '/login_agent', to: 'agent_sessions#create'
  post '/login_owner', to: 'owner_sessions#create'
  delete '/logout_agent', to: 'agent_sessions#destroy'
  delete '/logout_owner', to: 'owner_sessions#destroy'
  resources :agents
  resources :owners
end
