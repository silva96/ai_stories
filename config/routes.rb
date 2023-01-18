# frozen_string_literal: true

Rails.application.routes.draw do
  root 'site#index'

  resources :stories, except: %i[edit] do
    resources :pages, only: :show
  end

  resources :users, only: %i[create update destroy]

  get '/dashboard', to: 'users#show'
  get '/settings', to: 'users#edit'
  get  '/sign_up', to: 'users#new'
  get  '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  delete '/sign_out', to: 'sessions#destroy'
end
