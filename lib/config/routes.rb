# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      devise_for :users, skip: :all
      post 'sign_in', to: 'sessions#create'
      post 'refresh', to: 'sessions#refresh'
      delete 'logout', to: 'sessions#destroy'
      
      resources :users, only: :show
    end

    namespace :admin, format: :json do
      devise_for :admins, skip: :all
      post 'sign_in', to: 'sessions#create'
      post 'refresh', to: 'sessions#refresh'
      delete 'logout', to: 'sessions#destroy'

      resources :users, only: :index
    end
  end

  get '/app-docs', to: redirect('/swagger/v1/app.html')
  get '/admin-docs', to: redirect('/swagger/admin/admin.html')
end
