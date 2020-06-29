# frozen_string_literal: true

require "rails_helper"

RSpec.describe SettingsController, type: :controller do
  render_views
  setup_system_admin

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
