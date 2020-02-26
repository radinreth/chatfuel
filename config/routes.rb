# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#show'

  # TODO: only authenticated user
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  guisso_for :user

  resource :manifest, only: [:show]
  resources :voice_messages, only: [:create]
  resources :dictionaries, only: [:index, :update]
  resources :sites
  resources :tracks, only: [:create]
  resources :reports, only: [:index]
  resources :messages, only: [:create] do
    collection do
      post :continue
      post :done
    end
  end
end
