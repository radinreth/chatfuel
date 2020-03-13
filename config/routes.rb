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
  resources :dictionaries, only: [:index, :update]
  resources :sites do
    post "import", on: :collection
  end
  resources :tracks, only: [:create]
  resources :reports, only: [:index]
  resources :messages, only: [:create] do
    collection do
      post :continue
      post :done
    end
  end
end
