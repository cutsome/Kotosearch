Rails.application.routes.draw do
  root to: 'home#index'
  get '/help', to: 'home#help'
  get '/signup_agent', to: 'agents#new'
  get '/signup_owner', to: 'owners#new'
  resources :agents
  resources :owners
end
