Rails.application.routes.draw do

  resources :questions, except: [:destroy] do
    resources :answers, only: [:new, :create, :edit, :update]
  end
  resources :votes, only: [:create]
  resources :users, only:[:show,:edit,:update,:create,:new]
  resources :sessions, only: [:new, :create]
  get 'login' => 'sessions#new'

end
