# == Schema Information
#
# Table name: step_values
#
#  id                :bigint(8)        not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  message_id        :bigint(8)        not null
#  site_id           :bigint(8)
#  variable_id       :bigint(8)        not null
#  variable_value_id :bigint(8)        not null
#
# Indexes
#
#  index_step_values_on_message_id         (message_id)
#  index_step_values_on_site_id            (site_id)
#  index_step_values_on_variable_id        (variable_id)
#  index_step_values_on_variable_value_id  (variable_value_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (site_id => sites.id)
#  fk_rails_...  (variable_id => variables.id)
#  fk_rails_...  (variable_value_id => variable_values.id)
#
require 'rails_helper'

RSpec.describe StepValue, type: :model do
  describe '.after_commit, on_create' do
    context '#set_message_district_id' do
      let!(:variable) { create(:variable, marks_as: ['location'])}
      let!(:variable_value) { create(:variable_value, raw_value: '0102', variable: variable) }
      let!(:step_value) { create(:step_value, variable_value: variable_value, variable: variable) }

      it { expect(step_value.message.district_id).to eq('0102') }
    end

    context '#set_message_feedback_location_code' do
      let!(:variable) { create(:variable, marks_as: ['feedback_location'])}
      let!(:variable_value) { create(:variable_value, raw_value: '0103', variable: variable) }
      let!(:step_value) { create(:step_value, variable_value: variable_value, variable: variable) }

      it { expect(step_value.message.feedback_location_code).to eq('0103') }
    end

    context '#push_notification' do
      let!(:variable) { create(:variable, marks_as: ['report'])}
      let!(:variable_value) { create(:variable_value, raw_value: 'good', variable: variable) }
      let!(:site_setting) { create(:site_setting, message_frequency: 1) }
      let!(:message) { create(:message, feedback_location_code: site_setting.site.code) }
      let!(:step_value) { build(:step_value, message: message, variable_value: variable_value, variable: variable) }

      it "triggers push_notification" do
        expect(step_value).to receive(:push_notification)
        step_value.save
      end

      it { expect { step_value.save }.to change { ActiveJob::Base.queue_adapter.enqueued_jobs.count }.by 1 }
    end
  end

  describe ".most_recent" do
    let(:variable) { build(:variable) }
    let(:first_value) { build(:variable_value, id: 1) }
    let(:last_value) { build(:variable_value, id: 2) }

    before do
      create(:step_value, variable: variable, variable_value: first_value)
      create(:step_value, variable: variable, variable_value: last_value)
    end

    it "return lastest step_value" do
      most_recent = described_class.most_recent

      expect(most_recent.length).to eq 1
      expect(most_recent.first.variable_value).to eq last_value
    end
  end
end
