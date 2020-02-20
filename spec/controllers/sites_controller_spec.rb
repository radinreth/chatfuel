require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  it 'GET :index' do
    get :index

    expect(response).to render_template("index")
  end

  it 'GET :show' do
    get :show, params: { id: create(:site).id }

    expect(response).to render_template("show")
  end
end
