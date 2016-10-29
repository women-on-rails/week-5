Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  delete '/curiosities/:id', to: 'curiosities#destroy', as: 'curiosities'
  get '/curiosities/:id', to: 'curiosities#show'
end
