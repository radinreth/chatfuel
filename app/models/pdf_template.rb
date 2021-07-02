# == Schema Information
#
# Table name: pdf_templates
#
#  id         :bigint(8)        not null, primary key
#  content    :text             default("")
#  lang_code  :string           default(NULL)
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PdfTemplate < ApplicationRecord
  enum lang_code: { en: :en, km: :km }

  validates :name, :lang_code, presence: true
  validates :lang_code, inclusion: { in: I18n.available_locales.map(&:to_s) }
end
