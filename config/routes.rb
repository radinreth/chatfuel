# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  guisso_for :user

  root 'welcome#index'
  get 'welcome/index'

  resources :threads, only: %i[index create] do
    post :continue, on: :collection
  end
end
