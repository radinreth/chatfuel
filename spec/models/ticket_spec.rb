# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint(8)        not null, primary key
#  actual_completed_at :date
#  approved_date       :datetime
#  code                :string           not null
#  completed_at        :date
#  delivery_date       :datetime
#  dist_gis            :string
#  incomplete_at       :date
#  incorrect_at        :date
#  requested_date      :datetime
#  service_description :string
#  status              :string
#  tell                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  site_id             :bigint(8)        not null
#
# Indexes
#
#  index_tickets_on_code     (code)
#  index_tickets_on_site_id  (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
#
require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "attributes" do
    it { is_expected.to have_attribute(:code) }
    it { is_expected.to have_attribute(:status) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:site) }
  end

  describe "before validations" do
    let(:ticket) { create(:ticket) }

    it { expect(ticket.status).to eq('accepted') }
    it {
      ticket.update(status: 'Paid')
      expect(ticket.status).to eq('paid')
    }
  end

  describe "Notify to ticket's status to user" do
    let(:ticket) { create(:ticket, :accepted) }

    context "status change from: incomplete to: completed" do
      %w(approved rejected delivered).each do |status|
        it "enqueues a job" do
          expect do
            ticket.update status: status
          end.to have_enqueued_job(BroadcastJob).on_queue "default"
        end
      end
    end

    context "status does not change from: incomplete to: completed" do
      %w(accepted paid).each do |status|
        it "does not enqueue any job" do
          expect do
            ticket.update status: status
          end.not_to have_enqueued_job(BroadcastJob).on_queue "default"
        end
      end
    end
  end
end
