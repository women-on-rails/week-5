Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  get 'curiosities/:id', to: 'curiosities#show', as: 'curiosity'
  delete 'curiosities/:id', to: 'curiosities#destroy'
end
