require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  it 'GET :index' do
    get :index

    expect(response).to render_template("index")
  end

  it 'GET :new' do
    get :new

    expect(response).to render_template('new')
  end

  it 'GET :show' do
    get :show, params: { id: create(:site).id }

    expect(response).to render_template("show")
  end

  it 'POST :create' do
    post :create, params: { site: { name: 'new site', code: '0212' } }

    expect(response).to have_http_status(:created)
  end
end
