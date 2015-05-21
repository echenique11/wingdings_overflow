Rails.application.routes.draw do

  resources :users, only:[:show,:edit,:update,:create,:new]
  resources :sessions, only: [:new, :create]
  get 'login' => 'sessions#new'

  resources :questions, except: [:destroy] do
    resources :comments, except: [:index, :show]
    resources :answers, only: [:new, :create, :edit, :update] do
      resources :comments, except: [:index, :show]
    end
  end
  resources :votes, only: [:create]

end
