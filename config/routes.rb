RailsFilemanager::Engine.routes.draw do

  root to: 'filemanager_files#index'

  get '/filemanager_files/storage_free', to: 'filemanager_files#storage_free', via: :get
  resources :filemanager_files


end
