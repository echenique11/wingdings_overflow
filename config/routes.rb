Rails.application.routes.draw do

  resources :questions, except: [:destroy] do
    resources :answers, only: [:new, :create, :edit, :update]
  end
  resources :votes, only: [:create]
end
