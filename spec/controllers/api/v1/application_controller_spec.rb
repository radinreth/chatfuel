# frozen_string_literal: true

require 'rails_helper'

class BaseController < Api::V1::ApplicationController; end

RSpec.describe BaseController, type: :controller do
  controller(BaseController) do
    def index
      render json: {}, status: 200
    end

    def create
      render json: {}, status: 201
    end
  end

  describe '#restrict_access' do
    before :each do
      request.env['HTTP_ACCEPT'] = 'application/json'
    end

    context 'when no site' do
      it 'returns 401' do
        get :index
        expect(response.status).to eq(401)
      end
    end

    context 'when wrong site' do
      it 'returns 401' do
        request.headers['Authorization'] = "Bearer #{SecureRandom.hex}"
        get :index
        expect(response.status).to eq(401)
      end
    end

    context 'when valid token' do
      let! (:site) { create(:site) }

      before(:each) do
        request.headers['Authorization'] = "Bearer #{site.token}"
      end

      it 'returns 200' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'returns 201' do
        post :create
        expect(response.status).to eq(201)
      end
    end
  end
end
