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
  resources :voice_messages, only: [:create]
  resources :voice_feedbacks, only: [:create]
  resources :dictionaries, only: [:index, :new, :create, :update] do
    put :batch_update, on: :collection
  end
  resources :tracks, only: [:create]
  resources :feedbacks, only: [:create]

  # namespace :feedbacks do
  #   resource :chatbot, only: [:create]
  #   resource :ivr, only: [:create]
  # end

  resources :reports, only: [:index]

  resources :sites do
    post "import", on: :collection
  end

  resources :messages, only: [:create] do
    collection do
      post :continue
      post :done
    end
  end

  resources :settings, only: [:index] do
    collection do
      put :template
    end
  end
end
