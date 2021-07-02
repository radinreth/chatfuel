# == Schema Information
#
# Table name: pdf_templates
#
#  id         :bigint(8)        not null, primary key
#  content    :text             default("")
#  lang_code  :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PdfTemplate < ApplicationRecord
  validates :name, :lang_code, presence: true
end
