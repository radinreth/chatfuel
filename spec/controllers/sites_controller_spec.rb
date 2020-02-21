require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  it 'GET :index' do
    get :index

    expect(response).to render_template('index')
  end

  it 'GET :new' do
    get :new

    expect(response).to render_template('new')
  end

  it 'GET :edit' do
    get :edit, params: { id: create(:site).id }

    expect(response).to render_template('edit')
  end

  it 'GET :show' do
    get :show, params: { id: create(:site).id }

    expect(response).to render_template('show')
  end

  it 'POST :create' do
    post :create, params: { site: { name: 'new site', code: '0212' } }

    expect(response).to have_http_status(:created)
  end

  context 'updates' do
    let(:kamrieng) { create(:site, name: 'kamrieng', code: '0212') }

    it 'PUT :update' do
      put :update, params: { id: kamrieng.id, site: { name: 'bavil', code: '0211' } }

      expect(response).to have_http_status(:ok)
    end
  end
end
