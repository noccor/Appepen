Rails.application.routes.draw do

  root 'application#index'

  resources :menus
  resources :meals
  resources :ingredients
  resources :recipies

end
