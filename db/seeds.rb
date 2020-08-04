# frozen_string_literal: true

paths = Rails.root.join("db", "seed", "**", "*.rb")
Dir[paths].each { |f| require f }

# variables : text, voice
Track.destroy_all
Ticket.destroy_all
StepValue.destroy_all
Variable.destroy_all
TextMessage.destroy_all
VoiceMessage.destroy_all
Message.destroy_all
Site.destroy_all
User.where.not("email LIKE ?", "%instedd%").destroy_all
# Role.destroy_all

require_relative "variables.rb"
require_relative "sites.rb"
require_relative "roles.rb"
require_relative "users.rb"
require_relative "tickets.rb"


site_codes = Site.all.map(&:code)
# message : text, message
messages = []

# dashboad : total_user
messages_messenger = [
  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: "0212"
      }
    ]
  }
]
messages += messages_messenger

messages_telegram = [
  {
    platform_name: "Telegram",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: "0212"
      }
    ]
  }
]
messages += messages_telegram

messages_verboice = [
  {
    platform_name: "Verboice",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: "0212"
      }
    ]
  }
]
messages += messages_verboice

# most request service
begin
  variable = Variable.find_by!(is_most_request: true)
  req_steps = []
  values = variable.values.map(&:raw_value)
  20.times.each do
    req_steps << { name: variable.name, value: values.sample }
  end

  messages_most_request_service = [
    {
      platform_name: "Messenger",
      steps: req_steps
    }
  ]
  messages += messages_most_request_service
rescue ActiveRecord::RecordNotFound
  puts "Must set define `variable.is_most_request = true`"
end

# dashboard : total user visit

begin
  variable = Variable.find_by!(is_user_visit: true)
  visitor_steps = []
  values = variable.values.map(&:raw_value)
  20.times.each do
    visitor_steps << { name: variable.name, value: values.sample }
  end

  messages_total_user_visit_each_functions = [
    {
      platform_name: "Messenger",
      steps: visitor_steps
    }
  ]
  messages += messages_total_user_visit_each_functions
rescue ActiveRecord::RecordNotFound
  puts "Must set define `variable.is_user_visit = true`"
end


# dashboard : total feedback
begin
  variable = Variable.find_by!(report_enabled: true)
  feedback_steps = []
  values = variable.values.map(&:raw_value)
  20.times.each do
    feedback_steps << { name: variable.name, value: values.sample }
  end

  messages_total_user_feedback = [
    {
      platform_name: "Messenger",
      steps: feedback_steps
    }
  ]
  messages += messages_total_user_feedback
rescue ActiveRecord::RecordNotFound
  puts "Must set define `variable.report_enabled = true`"
end


# dashboard : total feedback
begin
  variable = Variable.find_by!(name: "tracking")
  tracking_steps = []
  values = variable.values.map(&:raw_value)
  20.times.each do
    site_code = site_codes.sample
    ticket_code = "#{site_code}#{FFaker::Code.ean[0...8]}"
    site = Site.find_by code: site_code
    Ticket.create code: ticket_code, site_id: site.id, status: [:incomplete, :completed].sample
    tracking_steps << { name: variable.name, value: ticket_code }
  end

  messages_total_user_feedback = [
    {
      platform_name: "Messenger",
      steps: tracking_steps
    }
  ]
  messages += messages_total_user_feedback
rescue ActiveRecord::RecordNotFound
  puts "Must set define `variable.report_enabled = true`"
end

puts "creating messages"
1.times.each do
  attributes = messages.deep_dup
  attributes.each do |message_attributes|
    print "."
    platform_name = message_attributes.delete(:platform_name)
    steps = message_attributes.delete(:steps)

    if platform_name == "Verboice"
      callsid = FFaker::Code.ean[0...4]
      content = VoiceMessage.find_or_create_by(callsid: callsid)
      message = Message.create_or_return(platform_name, content)

      if steps.present?
        steps.each do |step|
          variable = Variable.find_or_create_by(name: step[:name])
          variable_value = variable.values.find_or_create_by(raw_value: step[:value])
          step_value = message.step_values.create(variable_value: variable_value, variable: variable)
          step_value.update(created_at: (0...6).to_a.sample.days.ago)
        end
      end
    else
      messenger_user_id = FFaker::Code.ean
      content = TextMessage.find_or_create_by(messenger_user_id: messenger_user_id)
      message = Message.create_or_return(platform_name, content)

      # .take(rand(1...steps.count))
      if steps.present?
        steps.each do |step|
          variable = Variable.find_or_create_by(name: step[:name])
          variable_value = variable.values.find_or_create_by(raw_value: step[:value])
          step_value = message.step_values.create(variable_value: variable_value, variable: variable)
          step_value.update(created_at: (0...6).to_a.sample.days.ago)
        end
      end
    end
  end
end

puts "", "Done"
