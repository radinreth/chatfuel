require 'rails_helper'

RSpec.describe Sites::PdfTemplatesController, type: :controller do
  setup_system_admin

  describe 'GET :show' do
    let(:pdf_template) { create(:pdf_template) }
    let(:site) { create(:site) }

    context 'when format=html' do
      it 'renders html template' do
        get :show, params: { site_code: site.code, id: pdf_template.id }

        expect(response).to render_template('sites/pdf_templates/show.html')
      end
    end

    context 'when format=pdf' do
      it 'renders html template' do
        get :show, params: { site_code: site.code, id: pdf_template.id }, format: "pdf"

        expect(assigns[:pdf_template]).to be_decorated
        expect(response).to render_template('sites/pdf_templates/show.html')
        expect(response.content_type).to eq "application/pdf"
      end
    end
  end
end
