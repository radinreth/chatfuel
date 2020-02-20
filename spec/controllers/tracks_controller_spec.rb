RSpec.describe TracksController do
  before do
    content = create(:text_message, messenger_user_id: 123)
    create(:message, content: content)
  end

  it 'POST :create' do
    post :create, params: { klass: 'TextMessage', messenger_user_id: 123, track: { code: '1234-56789' } }

    expect(response).to have_http_status(:created)
  end
end
