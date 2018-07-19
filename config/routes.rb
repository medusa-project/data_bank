Rails.application.routes.draw do
  resources :datafiles, param: :web_id
  resources :datasets, param: :key do
    resources :datafiles, param: :web_id
  end
  root 'datasets#index'
end
