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

  describe "PUT #template" do
    context "create setting" do
      it "should created setting" do
        expect {
          put :template, params: { setting: { incompleted_text: "your ticket is not ready yet." } }
        }.to change(Setting, :count).from(0).to(1)
      end

      it "should save audio" do
        put :template, params: { setting: { completed_audio: fixture_file_upload(file_path("completed_audio.mp3"), "audio/mpeg"), incompleted_audio: fixture_file_upload(file_path("incompleted_audio.mp3"), "audio/mpeg") } }
        expect(subject).to redirect_to(settings_path)
        expect(subject.request.flash[:notice]).to eq("successfully updated message template")
      end
    end

    context "update setting" do
      let!(:setting) { create(:setting, :with_completed_audio) }

      it "should update existing setting" do
        put :template, params: { setting: { id: setting.id, incompleted_text: "your ticket is not ready yet." } }

        expect(Setting.count).to eq(1)
        expect(subject).to redirect_to(settings_path)
        expect(subject.request.flash[:notice]).to eq("successfully updated message template")
      end
    end
  end

  context "unsucessful save record" do
    before(:each) do
      put :template, params: { setting: { incompleted_audio: fixture_file_upload(file_path("site.csv")) } }
    end

    it "should redirect to index page" do
      expect(subject).to render_template(:index)
    end

    it "should flash error message" do
      expect(subject.request.flash[:alert]).to eq("cannot update message template")
    end
  end
end
