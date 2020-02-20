RSpec.describe TracksController do
  before do
    content = create(:text_message, messenger_user_id: 123)
    create(:message, content: content)
  end

  it 'POST :create' do
    params = { klass: 'TextMessage', messenger_user_id: 123, code: '1234-56789' }

    post :create, params: params

    expect(response).to have_http_status(:ok)
  end
end
