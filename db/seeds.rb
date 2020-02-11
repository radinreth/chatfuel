# frozen_string_literal: true

Message.destroy_all
Dictionary.destroy_all

dictionaries = [
  { value: 'f1',    header: 'Main menu' },
  { value: 'f11',   header: 'owso info options' },
  { value: 'f111',  header: 'អត្រានុកូលដ្ឋាន options' },
  { value: 'f112',  header: 'អាជីវកម្ម options' },
  { value: 'f113',  header: 'សុរិយោដី options' },
  { value: 'f121',  header: 'Feed text' },
  { value: 'f122',  header: 'feed voice' },
  { value: 'f131',  header: 'Ticket id' }
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
