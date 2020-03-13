# frozen_string_literal: true
require "sidekiq/web"
require_relative "whitelist"

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  guisso_for :user

  root "dashboard#show"
  get :dashboard, to: "dashboard#show"
  get :home, to: "home#show"

  authenticate :user, ->(user) { user.system_admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  scope "/role" do
    resources :users
  end

  resource :manifest, only: [:show], defaults: { format: "xml" }, constraints: Whitelist.new
  resources :tickets
  resources :templates
  resources :quotas, only: [:index]
  resources :voice_messages, only: [:create]
  resources :dictionaries, only: [:index, :new, :create, :update] do
    put :batch_update, on: :collection
  end
  resources :tracks, only: [:create]
  resources :feedbacks, only: [:create]
  resources :reports, only: [:index]
  resources :sites do
    collection do
      get :new_import
      post :import
    end
  end

  resources :settings, only: [:index] do
    collection do
      put :template
    end
  end

  namespace :bots do
    resources :voice_feedbacks, only: [:create]

    # Message
    resources :messages, only: [:create] do
      collection do
        post "ivr", to: "messages/ivr#create"
        post "chatbot", to: "messages/chatbot#create"
        post "chatbot/done", to: "messages/chatbot#done"
      end
    end

    # Feedback
    resources :feedbacks, only: [:create] do
      collection do
        post "ivr", to: "feedbacks/ivr#create"
      end
    end

    # Track
    resources :tracks, only: [:create] do
      collection do
        post "ivr", to: "tracks/ivr#create"
        post "chatbot", to: "tracks/chatbot#create"
      end
    end
  end

end
