Rails.application.routes.draw do
  get '/results', to: 'result#index'

  devise_for :users
  resources :participants
  
  resources :user_groups
  
  root to: "rapidfire/question_groups#index"
  # root 'home#index'
  get '/home', to: 'home#index', as: 'home'
  get '/about', to: 'home#about'

  # get '/results/:id', to: 'result#show', as: 'results'
  get '/question_groups/:id/results', to: 'result#show'
  get '/question_groups/:question_group_id/participants/:id', to: 'result#participant'
  mount Rapidfire::Engine => "/"
  get '/group/:question_group_id/questions/new', to: 'questions#new'
end
