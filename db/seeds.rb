# frozen_string_literal: true

Message.destroy_all
Dictionary.destroy_all

dictionaries = [
  { variable_name: 'f1', value: '',    title: 'Main menu' },
  { variable_name: 'f11', value: '',   title: 'owso info options' },
  { variable_name: 'f111', value: '',  title: 'អត្រានុកូលដ្ឋាន options' },
  { variable_name: 'f112', value: '',  title: 'អាជីវកម្ម options' },
  { variable_name: 'f113', value: '',  title: 'សុរិយោដី options' },
  { variable_name: 'f121', value: '',  title: 'Feed text' },
  { variable_name: 'f122', value: '',  title: 'feed voice' },
  { variable_name: 'f131', value: '',  title: 'Ticket id' }
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
