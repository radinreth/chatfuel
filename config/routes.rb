# frozen_string_literal: true
require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  guisso_for :user

  root "homes#show"

  authenticate :user, ->(user) { user.system_admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  scope "/role" do
    resources :users
  end

  resource :manifest, only: [:show]
  resources :dictionaries, only: [:index, :new, :create, :update, :destroy] do
    put :batch_update, on: :collection
    resources :values, only: [:destroy]
  end

  resources :reports, only: [:index]
  resources :sites do
    collection do
      get :new_import
      post :import
    end
  end

  namespace :bots do
    # Message
    resources :messages, only: [:create] do
      collection do
        post "ivr", to: "messages/ivr#create"
        post "chatbot", to: "messages/chatbot#create"
      end
    end

    # Feedback
    resources :feedbacks, only: [:create] do
      collection do
        post "ivr", to: "feedbacks/ivr#create"
        post "chatbot", to: "feedbacks/chatbot#create"
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

  resources :settings, only: [:index] do
    collection do
      put :template
    end
  end
end
