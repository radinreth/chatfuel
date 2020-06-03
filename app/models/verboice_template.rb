# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("0")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class VerboiceTemplate < Template
  def self.model_name
    Template.model_name
  end

  def platform_value
    2
  end

  def human_name
    "verboice"
  end
end
