# frozen_string_literal: true

Rails.application.routes.draw do
  root 'site#index'
  resources :stories, except: %i[edit destroy] do
    resources :pages, only: :show
  end
end
