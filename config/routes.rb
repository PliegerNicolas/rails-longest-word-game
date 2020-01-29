Rails.application.routes.draw do
  get 'new', to: 'games#new'
  get 'index', to: 'games#index'
  post 'score', to: 'games#score'
  # For details, on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
