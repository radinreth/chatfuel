require 'rails_helper'

RSpec.describe "PdfTemplates", type: :request do
  let(:pdf_template) { create(:pdf_template) }
  login_system_admin

  describe "GET /index" do
    it "returns http success" do
      get "/pdf_templates"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/pdf_templates/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/pdf_templates/#{pdf_template.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      post "/pdf_templates", params: { pdf_template: { name: "test template", content: "HTML content", lang_code: "km" } }
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/pdf_templates/#{pdf_template.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT /update" do
    it "returns http success" do
      put "/pdf_templates/#{pdf_template.id}", params: { pdf_template: { name: "test template", content: "HTML content", lang_code: "km" } }
      expect(response).to have_http_status(:found)
    end
  end

  describe "DELETE /destroy" do
    it "returns http success" do
      delete "/pdf_templates/#{pdf_template.id}"
      expect(response).to have_http_status(:found)
    end
  end

end
