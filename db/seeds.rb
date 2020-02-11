# frozen_string_literal: true

Message.destroy_all
Dictionary.destroy_all

dictionaries = [
  { value: "f1"   },
  { value: "f11"  },
  { value: "f111" },
  { value: "f112" },
  { value: "f113" },
  { value: "f121" },
  { value: "f122" },
  { value: "f131" }
]

Dictionary.create dictionaries

text_messages = [
  {
    messenger_user_id: 1,
    first_name: 'bopha'
  },
  {
    messenger_user_id: 2,
    first_name: 'dara'
  },
  {
    messenger_user_id: 3,
    first_name: 'visal'
  },
  {
    messenger_user_id: 4,
    first_name: 'virak'
  }
]

text_messages.each do |text|
  Message.create content: TextMessage.create(text)
end


voice_messages = [
  {
    call_id: 1,
    address: 123
  },
  {
    call_id: 2,
    address: 124
  },
  {
    call_id: 3,
    address: 125
  },
  {
    call_id: 4,
    address: 125
  }
]

voice_messages.each do |voice|
  Message.create content: VoiceMessage.create(voice)
end
