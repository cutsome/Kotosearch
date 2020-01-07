Rails.application.routes.draw do

  controller :home do
    root 'home#index'
    get :search
    get :agent_result
    get :owner_result
  end

  get '/agent_signup', to: 'agents#new'
  get '/owner_signup', to: 'owners#new'
  get '/agent_login', to: 'agent_sessions#new'
  get '/owner_login', to: 'owner_sessions#new'
  post '/agent_login', to: 'agent_sessions#create'
  post '/owner_login', to: 'owner_sessions#create'
  delete '/agent_logout', to: 'agent_sessions#destroy'
  delete '/owner_logout', to: 'owner_sessions#destroy'

  resources :agents
  resources :owners
  resources :targets
  resources :leisures

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
