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

Ticket.destroy_all
Site.destroy_all
Message.destroy_all

Seed::Site.generate!
Seed::Ticket.generate!

ticket_codes = Ticket.take(100).pluck(:code)

text_messages = [
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "certify_doc"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "gender",
    raw_value: "m"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "location_name",
    raw_value: ["Kandal", "Banteay Meanchey"].sample
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "main_dbs"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "main_construction"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "main_dbs"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "main_construction"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "main_dbs"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "owso_info",
    raw_value: "certify_doc"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_dbs",
    raw_value: "main_dbs 1"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_level",
    raw_value: "province"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_construction",
    raw_value: "construction 1"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },

  { 
    callsid: 5,
    platform_name: "Verboice",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },



  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "tracking"
  },

  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "feedback"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "owso_info"
  },
  { 
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "main_menu",
    raw_value: "tracking"
  },

  # track
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[0]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[1]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[2]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[3]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[4]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[5]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[6]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[7]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[8]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[9]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[10]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[11]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[12]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[13]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[14]
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    code: ticket_codes[15]
  },

  # feedback
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_challenge",
    raw_value: "high_price"
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_challenge",
    raw_value: "form_complicate"
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_challenge",
    raw_value: "take long time"
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_challenge",
    raw_value: "take long time"
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_challenge",
    raw_value: "take long time"
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_q2",
    raw_value: "working_time"
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_q2",
    raw_value: "speech"
  },
  {
    messenger_user_id: FFaker::Code.ean,
    platform_name: "Messenger",
    dictionary_name: "feedback_q2",
    raw_value: "provide info"
  }
]

text_messages.each do |message|
  begin
    platform = message.delete(:platform_name)
    dictionary_name = message.delete(:dictionary_name)
    raw_value = message.delete(:raw_value)
    code = message.delete(:code)

    if message[:messenger_user_id].present?
      content = TextMessage.create(message)
    elsif message[:callsid].present?
      content = VoiceMessage.create(message)
    else
      raise "Invalid message"
    end

    msg = Message.create(platform_name: platform, content: content)

    step = msg.steps.build
    if dictionary_name.present?
      variable = TextVariable.find_or_create_by name: dictionary_name
      step.value = variable.values.find_or_create_by raw_value: raw_value
    else
      site = Site.find_by(code: code[0...4])
      ticket = Ticket.find_by(code: code, site: site)
      track = Track.create(code: code, site: site, ticket: ticket)
      step.track = track
    end

    step.save!
  rescue => e
    p e.inspect
    p msg&.errors
    p variable&.errors
  end
end
