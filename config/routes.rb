Rails.application.routes.draw do
  resources :datasets, param: :key
  root 'datasets#index'
end
