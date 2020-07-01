# frozen_string_literal: true
paths = Rails.root.join("db", "seed", "**", "*.rb")
Dir[paths].each { |f| require f }

# %w[Variable Ticket Site Message Track].each do |model|
#   model.constantize.send(:destroy_all)
#   unless ENV["create"]
#     p "create #{model}"
#     "Seed::#{model}".constantize.send(:generate!)
#   end
# end

Seed::Site.generate!
Seed::Ticket.generate!


Message.destroy_all
ticket_codes = Ticket.take(10).pluck(:code)

text_messages = [
  { 
    messenger_user_id: 1,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "certify doc"
  },
  { 
    messenger_user_id: 2,
    platform_name: "Messenger",
    dictionary_name: "main_dbs",
    raw_value: "main_dbs 1"
  },
  { 
    messenger_user_id: 3,
    platform_name: "Messenger",
    dictionary_name: "feedback_level",
    raw_value: "province"
  },
  { 
    messenger_user_id: 4,
    platform_name: "Messenger",
    dictionary_name: "main_construction",
    raw_value: "construction 1"
  },
  { 
    messenger_user_id: 5,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },



  { 
    messenger_user_id: 6,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },
  { 
    messenger_user_id: 7,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },
  { 
    messenger_user_id: 8,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "tracking"
  },

  { 
    messenger_user_id: 9,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "feedback"
  },
  { 
    messenger_user_id: 10,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },
  { 
    messenger_user_id: 11,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "tracking"
  },

  # track
  {
    messenger_user_id: 11,
    platform_name: "Messenger",
    code: ticket_codes[0]
  },
  {
    messenger_user_id: 12,
    platform_name: "Messenger",
    code: ticket_codes[1]
  },
  {
    messenger_user_id: 13,
    platform_name: "Messenger",
    code: ticket_codes[2]
  },
  {
    messenger_user_id: 14,
    platform_name: "Messenger",
    code: ticket_codes[3]
  },
  {
    messenger_user_id: 15,
    platform_name: "Messenger",
    code: ticket_codes[4]
  },
  {
    messenger_user_id: 16,
    platform_name: "Messenger",
    code: ticket_codes[5]
  },
  {
    messenger_user_id: 17,
    platform_name: "Messenger",
    code: ticket_codes[6]
  },
  {
    messenger_user_id: 18,
    platform_name: "Messenger",
    code: ticket_codes[7]
  }
]

text_messages.each do |message|
  begin
    platform = message.delete(:platform_name)
    dictionary_name = message.delete(:dictionary_name)
    raw_value = message.delete(:raw_value)
    code = message.delete(:code)

    content = TextMessage.create(message)

    msg = Message.create(platform_name: platform, content: content)

    step = msg.steps.build
    if dictionary_name.present?
      variable = TextVariable.find_or_create_by name: dictionary_name
      step.value = variable.values.find_or_create_by raw_value: raw_value
    else
      site = Site.find_by(code: code[0...4])
      ticket = Ticket.find_by(code: code)
      track = Track.create(code: code, site: site, ticket: ticket)
      step.track = track
    end

    step.save
  rescue
    p msg&.errors
    p variable&.errors
    p variable_value&.errors
  end
end
