# frozen_string_literal: true
require "sidekiq/web"
require_relative "whitelist"

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  guisso_for :user

  root "dashboard#show"
  get :dashboard, to: "dashboard#show"
  get :home, to: "home#index"

  namespace :dashboard do
    get "chatbot", action: :show, controller: "chatbot_dashboard"
    get "ivr", action: :show, controller: "ivr_dashboard"
  end

  authenticate :user, ->(user) { user.system_admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  scope "/role" do
    resources :users
  end

  resource :manifest, only: [:show], defaults: { format: "xml" }, constraints: Whitelist.new
  resources :tickets do
    get :search, on: :collection
  end
  resources :templates
  resources :quotas, only: [:index]
  resources :voice_messages, only: [:create]
  resources :voice_feedbacks, only: [:create]
  resources :dictionaries, only: [:index, :new, :create, :edit, :update] do
    post :set_most_request, on: :collection
  end
  resources :tracks, only: [:create]
  resources :feedbacks, only: [:create]
  resources :reports, only: [:index]
  resources :sites do
    collection do
      get :new_import
      post :import
    end

    scope module: :sites do
      resource :setting, only: [:show, :create, :update]
      resource :api_key
    end
  end

  namespace :bots do
    resource :gender, only: [:create]
    resource :location, only: [:create]

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

  resources :settings, only: [:index] do
    collection do
      put :telegram_bot
    end
  end

  namespace :bots do

    resources :voice_feedbacks, only: [:create]
    resources :feedbacks, only: [:create]

    resources :messages, only: [:create] do
      collection do
        post "ivr", to: "messages/ivr#create"
        post "chatbot", to: "messages/chatbot#create"
      end
    end

    # Tracking
    resources :tracks, only: [:create] do
      collection do
        post "ivr", to: "tracks/ivr#create"
        post "chatbot", to: "tracks/chatbot#create"
      end
    end
  end

  # Telegram
  telegram_webhook TelegramWebhooksController
  concern :api_base do
    resources :sites, param: :site_code, only: [:update]
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      put :me, controller: "sites", action: "check"
      concerns :api_base
    end
  end

  mount Pumi::Engine => "/pumi"
end
