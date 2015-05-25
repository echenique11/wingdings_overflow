Rails.application.routes.draw do
  resources :users, only:[:show,:edit,:update,:create,:new]
  get 'signup' => 'users#new'

  resources :sessions, only: [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :questions, except: [:destroy] do
    resources :answers, only: [:create, :edit, :update]
  end

  resources :comments, except: [:index, :show, :new]
  resources :votes, only: [:new, :create]
  resources :tags, only: [:show, :index]

  root :to => 'questions#index'

  get 'users/:id/questions' => 'users#search_in_questions'
  get 'questions/:id/answers' => 'questions#answers'
end