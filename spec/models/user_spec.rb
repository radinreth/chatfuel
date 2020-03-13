require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to define_enum_for(:role).with_values(%i[ombudsman site_admin system_admin]) }
  it { is_expected.to define_enum_for(:status).with_values(%i[enable disable]) }
  it { is_expected.to have_many(:identities).dependent(:destroy) }

end
