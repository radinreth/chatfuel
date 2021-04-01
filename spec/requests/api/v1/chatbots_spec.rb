require "rails_helper"

RSpec.describe "Chatbots session", type: :request do
  it "starts a new session" do
    expect {
      post "/api/v1/chatbots", params: { messenger_user_id: "123", name: "gender", value: "m" }
    }.to change { Session.count }.by(1)
  end

  describe ":province" do
    let(:variable) { create(:variable, name: "province") }
    let(:value) { build(:variable_value, raw_value: "02") }

    before do
      variable.mark_as_province!
    end

    it "creates step :province" do
      post "/api/v1/chatbots", params: { messenger_user_id: "123", name: variable.name, value: value.raw_value }

      expect(Session.first.province_id).to eq(value.raw_value)
    end
  end

  describe ":district" do
    let(:variable) { create(:variable, name: "district") }
    let(:value) { build(:variable_value, raw_value: "0212") }

    before do
      variable.mark_as_district!
    end

    it "creates step :district" do
      post "/api/v1/chatbots", params: { messenger_user_id: "123", name: variable.name, value: value.raw_value }

      expect(Session.first.district_id).to eq(value.raw_value)
    end
  end

  describe ":gender" do
    let(:variable) { build(:variable, name: "gender") }
    let(:value) { build(:variable_value, raw_value: "m") }

    it "creates step :gender" do
      post "/api/v1/chatbots", params: { messenger_user_id: "123", name: variable.name, value: value.raw_value }

      step_value = StepValue.first
      expect(step_value.variable.name).to eq(variable.name)
      expect(step_value.variable_value.raw_value).to eq(value.raw_value)
    end
  end
end