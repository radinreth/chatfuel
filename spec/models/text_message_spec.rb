# == Schema Information
#
# Table name: text_messages
#
#  id                       :bigint           not null, primary key
#  messenger_user_id        :bigint
#  first_name               :string
#  last_name                :string
#  gender                   :string
#  profile_pic_url          :string
#  timezone                 :string
#  locale                   :string
#  source                   :string
#  last_seen                :string
#  signed_up                :string
#  sessions                 :string
#  last_visited_block_name  :string
#  last_visited_block_id    :string
#  last_clicked_button_name :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
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
