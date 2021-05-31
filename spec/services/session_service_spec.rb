require 'rails_helper'

RSpec.describe SessionService do
  describe '.create' do
    specify do
      expect {
        SessionService.create("123456") do |session|
          session.add_value('owso_info', 'certify_docs').append_steps
        end
      }.to change { Session.count }.by(1)
      .and change { Variable.count }.by(1)
      .and change { StepValue.count }.by(1)
    end
  end
end
