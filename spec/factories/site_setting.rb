FactoryBot.define do
  factory :site_setting do
    enable_notification  { true }
    message_template     {"Here is client's feedback {{feedback_message}}"}
    digest_message_template   {"Here is client's feedback {{feedback_count}}"}
    site
    message_frequency    { 'immediately' }
  end
end
