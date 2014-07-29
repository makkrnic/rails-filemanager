Rails.application.routes.draw do

  resources :owners

  scope ':owner' do
    mount RailsFilemanager::Engine => "/rails_filemanager"
  end
end
