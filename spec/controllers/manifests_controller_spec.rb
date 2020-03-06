RSpec.describe ManifestsController, type: :controller do
  stub_system_admin

  it 'GET :show' do
    get :show, format: :xml

    expect(response).to render_template("show")
  end
end
