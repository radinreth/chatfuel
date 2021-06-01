require "rails_helper"

RSpec.describe "Chatbots session", type: :request do
  before {
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
  }

  it "starts a new session" do
    expect {
      post "/api/v1/chatbots", params: { messenger_user_id: "123", name: "gender", value: "m" }
    }.to have_performed_job(Session::ChatbotJob)
  end

  describe ":province" do
    let(:variable) { create(:variable, name: "province") }
    let(:value) { build(:variable_value, raw_value: "02") }

    before do
      variable.mark_as_province!
    end

    it "creates step :province" do
      expect {
        post "/api/v1/chatbots", params: { messenger_user_id: "123", name: variable.name, value: value.raw_value }
      }.to have_performed_job(Session::ChatbotJob)
    end
  end

  describe ":district" do
    let(:variable) { create(:variable, name: "district") }
    let(:value) { build(:variable_value, raw_value: "0212") }

    before do
      variable.mark_as_district!
    end

    it "creates step :district" do

      expect {
        post "/api/v1/chatbots", params: { messenger_user_id: "123", name: variable.name, value: value.raw_value }
      }.to have_performed_job(Session::ChatbotJob)
    end
  end

  describe ":gender" do
    let(:variable) { build(:variable, name: "gender") }
    let(:value) { build(:variable_value, raw_value: "m") }

    it "creates step :gender" do
      expect {
        post "/api/v1/chatbots", params: { messenger_user_id: "123", name: variable.name, value: value.raw_value }
      }.to have_performed_job(Session::ChatbotJob)
    end
  end
end