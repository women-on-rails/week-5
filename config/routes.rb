Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  get '/curiosities/:id', to: 'curiosities#show', as: 'curiosities'

end
