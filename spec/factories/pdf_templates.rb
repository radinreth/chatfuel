FactoryBot.define do
  factory :pdf_template do
    name { "pdf title" }
    content { "pdf content" }
    lang_code { ['en', 'km'].sample }
  end
end
