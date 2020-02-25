# == Schema Information
#
# Table name: text_messages
#
#  id                       :bigint(8)        not null, primary key
#  first_name               :string
#  gender                   :string
#  last_clicked_button_name :string
#  last_name                :string
#  last_seen                :string
#  last_visited_block_name  :string
#  locale                   :string
#  profile_pic_url          :string
#  sessions                 :string
#  signed_up                :string
#  source                   :string
#  timezone                 :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  last_visited_block_id    :string
#  messenger_user_id        :bigint(8)
#
RSpec.describe TextMessage do
  describe 'associations' do
    it { should have_one(:message).dependent(:destroy) }
    it { should have_many(:steps).through(:message) }
  end

  it '#type' do
    msg = build(:text_message)

    expect(msg.type).to eq 'Chatbot'
  end

  it 'alias_attribute' do
    msg = build(:text_message, messenger_user_id: 123)

    expect(msg.session_id).to eq msg.messenger_user_id
  end
end
