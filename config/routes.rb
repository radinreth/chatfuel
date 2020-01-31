# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  guisso_for :user
  
  root 'homes#show'
  resources :messages, only: [:create] do
    post :done, on: :collection
  end
end
