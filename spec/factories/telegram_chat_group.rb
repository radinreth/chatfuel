FactoryBot.define do
  factory :telegram_chat_group do
    title     {'mygroup'}
    bot_token {''}
    chat_type {'group'}
    is_active {true}
    chat_id   {'111'}
  end
end
