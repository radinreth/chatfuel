RSpec.describe ManifestsController do
  it 'GET :show' do
    get :show, format: :xml

    expect(response).to render_template("show")
  end
end
