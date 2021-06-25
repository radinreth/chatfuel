require 'rails_helper'

RSpec.describe "PdfTemplates::Sites", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/pdf_templates/sites/show"
      expect(response).to have_http_status(:success)
    end
  end

end
