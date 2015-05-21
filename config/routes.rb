Rails.application.routes.draw do

  resources :answers, only [:new, :create, :edit, :update]
  resources :votes, only [:create]
end
