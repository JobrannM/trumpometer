Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'daily_analyses#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :daily_analyses, only: [:show]
end
