Rails.application.routes.draw do
  root to: 'home#index'
  get '/help', to: 'home#help'
  get '/signup_agent', to: 'agents#new'
  post '/signup_agent', to: 'agents#create'
  resources :agents
end
