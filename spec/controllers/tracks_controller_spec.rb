RSpec.describe TracksController do
  it 'POST :create' do
    post :create, params: { track: { code: '1234-56789' } }

    expect(response).to have_http_status(:created)
  end
end
