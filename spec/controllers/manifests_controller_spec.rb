RSpec.describe ManifestsController, type: :controller do
  setup_system_admin

  it 'GET :show' do
    get :show, format: :xml

    expect(response).to render_template("show")
  end
end
