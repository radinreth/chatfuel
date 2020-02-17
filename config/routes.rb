# frozen_string_literal: true

Rails.application.routes.draw do
  get 'dictionaries/index'
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  guisso_for :user
  root 'homes#show'
  resource :manifest, only: [:show]
  resources :voice_messages, only: [:create]
  resources :dictionaries, only: [:index]
  resources :messages, only: [:create] do
    collection do
      post :continue
      post :done
    end
  end
end
