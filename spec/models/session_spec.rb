# == Schema Information
#
# Table name: sessions
#
#  id                  :bigint(8)        not null, primary key
#  last_interaction_at :datetime
#  platform_name       :string           default("")
#  status              :integer(4)       default("0")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  district_id         :string
#  province_id         :string
#  session_id          :string           not null
#
require 'rails_helper'

RSpec.describe Session, type: :model do
  it { is_expected.to define_enum_for(:status).with_values(%i[incomplete completed]) }

  describe ".create_or_return" do
    let!(:session) { Session.create_or_return("Messenger", "123") }

    context "create" do
      it "creates when it's new" do
        expect {
          Session.create_or_return("Messenger", "9999")
        }.to change { Session.count }.by 1
      end

      it "creates when it's completed" do
        session.completed!

        expect {
          Session.create_or_return("Messenger", "123")
        }.to change { Session.count }.by 1
      end
    end

    context "return" do
      it "returns when it's already created and incomplete" do
        expect {
          Session.create_or_return("Messenger", "123")
        }.not_to change { Session.count }
      end
    end
  end

  describe 'set_province_id' do
    let(:session) { (:session, district_id: '03122345') }

    it "extracts province_id from district_id before update" do
      session.update(district_id: '01234567')

      expect(session.reload.province_id).to eq('03')
    end
  end

end
