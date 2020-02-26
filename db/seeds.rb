# frozen_string_literal: true
Dir[Rails.root.join('db', 'seed', '**', '*.rb')].each { |f| require f }

Variable.destroy_all
Site.destroy_all

Seed::Ticket.generate!
Seed::Site.generate!

# text_messages = []
# voice_messages = []
# Message.destroy_all
# messages = [
#   {
#     content_type: '',
#     content_id: 0
#   }
# ]
# Message.create(messages)

# steps = [
#   {
#     message_id
#   }
# ]

# tracks = [
#   {
#     site
#     step
#     ticket
#   }
# ]

variables = [
  {
    type: 'VoiceVariable',
    name: 'main_menu',
    value: '1',
    text: 'សេវាកម្មសំខាន់ៗ'
  },
  {
    type: 'VoiceVariable',
    name: 'main_menu',
    value: '2',
    text: 'ផ្ដល់មតិយោបល់'
  },
  {
    type: 'VoiceVariable',
    name: 'main_menu',
    value: '3',
    text: 'តាមដានឯកសារ'
  },
  {
    type: 'VoiceVariable',
    name: 'owso_options',
    value: '1',
    text: 'បញ្ជាក់ឯកសារ'
  },
  {
    type: 'VoiceVariable',
    name: 'owso_options',
    value: '2',
    text: 'សេវាកម្មផ្សេងៗ'
  },
  {
    type: 'VoiceVariable',
    name: 'certify_options',
    value: '1',
    text: 'បញ្ចាក់កំណើត'
  },
  {
    type: 'VoiceVariable',
    name: 'certify_options',
    value: '2',
    text: 'បញ្ជាក់សៀវភៅគ្រួសារ'
  },
  {
    type: 'VoiceVariable',
    name: 'other_options',
    value: '1',
    text: 'អាហារដ្ឋាន'
  },
  {
    type: 'VoiceVariable',
    name: 'other_options',
    value: '2',
    text: 'ហាងធ្វើសក់'
  },
  {
    type: 'VoiceVariable',
    name: 'feedback_options',
    value: '1',
    text: 'ផ្ដល់យោបល់'
  },
  {
    type: 'VoiceVariable',
    name: 'feedback_options',
    value: '2',
    text: 'ផ្ដល់យោបល់ជាសម្លេង'
  },
  {
    type: 'VoiceVariable',
    name: 'feedback_rating_options',
    value: '1',
    text: 'ពេញចិត្ត'
  },
  {
    type: 'VoiceVariable',
    name: 'feedback_rating_options',
    value: '2',
    text: 'មិនពេញចិត្ត'
  },
  {
    type: 'VoiceVariable',
    name: 'feedback_record_options',
    value: '',
    text: ''
  },
  {
    type: 'VoiceVariable',
    name: 'tracking_ticket',
    value: '',
    text: ''
  }
]

Variable.create(variables)
p 'variables created!'

sites = [
  {
    name: 'kamrieng',
    code: '0216'
  }
]

Site.create(sites)
p 'sites created!'
