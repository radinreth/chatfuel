# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  guisso_for :user
  
  root 'homes#show'
  resources :threads, only: [:index]
  resources :messages, only: [:create] do
    collection do
      post :continue
      post :done
    end
  end
end
