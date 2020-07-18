# frozen_string_literal: true

paths = Rails.root.join("db", "seed", "**", "*.rb")
Dir[paths].each { |f| require f }

require_relative "district.rb"

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
variables = [
  {
    name: "main_menu",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: true,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "owso_info",
        mapping_value: ""
      },
      {
        raw_value: "tracking",
        mapping_value: ""
      },
      {
        raw_value: "feedback-intro",
        mapping_value: ""
      }
    ]
  },
  # owso_info
  {
    name: "owso_info",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: true,
    report_enabled: false,
    values: [
      {
        raw_value: "certify_docs",
        mapping_value: ""
      },
      {
        raw_value: "main_dbs",
        mapping_value: ""
      },
      {
        raw_value: "main_construction",
        mapping_value: ""
      },
      {
        raw_value: "main_land_title",
        mapping_value: ""
      },
      {
        raw_value: "main_public_transport",
        mapping_value: ""
      },
      {
        raw_value: "main_land_refill",
        mapping_value: ""
      }
    ]
  },
  # certify docs
  {
    name: "certify_docs",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "certify_doc_1",
        mapping_value: ""
      },
      {
        raw_value: "certify_doc_2",
        mapping_value: ""
      }
    ]
  },
  # main_dbs
  {
    name: "main_dbs",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "dbs_btn1",
        mapping_value: ""
      },
      {
        raw_value: "dbs_btn2",
        mapping_value: ""
      }
    ]
  },
  # dbs_btn1
  {
    name: "dbs_btn1",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "dbs_btn1_1",
        mapping_value: ""
      },
      {
        raw_value: "dbs_btn1_2",
        mapping_value: ""
      },
      {
        raw_value: "dbs_btn1_3",
        mapping_value: ""
      }
    ]
  },
  # dbs_btn2
  {
    name: "dbs_btn2",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "dbs_btn2_1",
        mapping_value: ""
      },
      {
        raw_value: "dbs_btn2_2",
        mapping_value: ""
      },
      {
        raw_value: "dbs_btn2_3",
        mapping_value: ""
      },
      {
        raw_value: "dbs_btn2_4",
        mapping_value: ""
      }
    ]
  },
  # dbs_btn2_2
  {
    name: "dbs_btn2_2",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "dbs_btn2_2_1",
        mapping_value: ""
      },
      {
        raw_value: "dbs_btn2_2_2",
        mapping_value: ""
      }
    ]
  },
  # main construction
  {
    name: "main_construction",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "construction_1",
        mapping_value: ""
      },
      {
        raw_value: "construction_2",
        mapping_value: ""
      },
      {
        raw_value: "construction_3",
        mapping_value: ""
      }
    ]
  },
  {
    name: "construction_1",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "construction_1.1",
        mapping_value: ""
      },
      {
        raw_value: "construction_1.2",
        mapping_value: ""
      },
      {
        raw_value: "construction_1.3",
        mapping_value: ""
      }
    ]
  },
  {
    name: "construction_2",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "construction_2.1",
        mapping_value: ""
      },
      {
        raw_value: "construction_2.2",
        mapping_value: ""
      },
      {
        raw_value: "construction_2.3",
        mapping_value: ""
      }
    ]
  },
  {
    name: "construction_3",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "construction_3.1",
        mapping_value: ""
      },
      {
        raw_value: "construction_3.2",
        mapping_value: ""
      },
      {
        raw_value: "construction_3.3",
        mapping_value: ""
      }
    ]
  },
  # main_land_title
  {
    name: "main_land_title",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "land title 1",
        mapping_value: ""
      },
      {
        raw_value: "land title 2",
        mapping_value: ""
      },
      {
        raw_value: "land title 3",
        mapping_value: ""
      }
    ]
  },
  {
    name: "land title 1",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "land title 1.1",
        mapping_value: ""
      },
      {
        raw_value: "land title 1.2",
        mapping_value: ""
      },
      {
        raw_value: "land title 1.3",
        mapping_value: ""
      }
    ]
  },
  {
    name: "land title 2",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "land title 2.1",
        mapping_value: ""
      },
      {
        raw_value: "land title 2.2",
        mapping_value: ""
      },
      {
        raw_value: "land title 2.3",
        mapping_value: ""
      }
    ]
  },
  {
    name: "land title 3",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "land title 3.1",
        mapping_value: ""
      },
      {
        raw_value: "land title 3.2",
        mapping_value: ""
      },
      {
        raw_value: "land title 3.3",
        mapping_value: ""
      }
    ]
  },
  # refill
  {
    name: "main_refill_title",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "land_refill 1",
        mapping_value: ""
      },
      {
        raw_value: "land_refill 2",
        mapping_value: ""
      }
    ]
  },
  {
    name: "land_refill 1",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "land_refill 1.1",
        mapping_value: ""
      },
      {
        raw_value: "land_refill 1.2",
        mapping_value: ""
      }
    ]
  },
  {
    name: "land_refill 2",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "land_refill 2.1",
        mapping_value: ""
      },
      {
        raw_value: "land_refill 2.2",
        mapping_value: ""
      },
      {
        raw_value: "land_refill 2.3",
        mapping_value: ""
      }
    ]
  },
  {
    name: "feedback-intro",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: []
  },
  {
    name: "feedback_level",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "krong battambong",
        mapping_value: ""
      },
      {
        raw_value: "district",
        mapping_value: ""
      }
    ]
  },
  {
    name: "feedback_challenge",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: true,
    values: [
      {
        raw_value: "high price",
        mapping_value: ""
      },
      {
        raw_value: "complicated",
        mapping_value: ""
      },
      {
        raw_value: "take long time",
        mapping_value: ""
      }
    ]
  },
  {
    name: "feedback_q2_like",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "working time",
        mapping_value: ""
      },
      {
        raw_value: "speech",
        mapping_value: ""
      },
      {
        raw_value: "provide info",
        mapping_value: ""
      }
    ]
  },
  {
    name: "feedback_q3_dislike",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "working time",
        mapping_value: ""
      },
      {
        raw_value: "speech",
        mapping_value: ""
      },
      {
        raw_value: "provide info",
        mapping_value: ""
      }
    ]
  },
  {
    name: "public_transport",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: [
      {
        raw_value: "transport 1",
        mapping_value: ""
      },
      {
        raw_value: "transport 2",
        mapping_value: ""
      }
    ]
  },
  {
    name: "tracking",
    type: "TextVariable",
    feedback_message: false,
    is_most_request: false,
    is_user_visit: false,
    report_enabled: false,
    values: []
  }
]

puts "creating Variables"
variables.each do |variable_params|
  values = variable_params.delete(:values)
  variable = Variable.new(variable_params)

  variable.values.build(values)
  unless variable.save
    puts variable_params
  end
end

# roles
roles = [
  {
    name: "system_admin",
    variables: ["owso_info", "tracking"]
  },
  {
    name: "site_admin",
    variables: ["owso_info"]
  },
  {
    name: "site_ombudsman",
    variables: ["feedback-intro"]
  }
]

puts "creating roles"
roles.each do |role_params|
  variables = role_params.delete(:variables)
  role = Role.find_or_initialize_by(role_params)

  role.variables = variables.map do |variable_name|
    Variable.find_by name: variable_name
  end.compact
  role.save
end


# site
# setup site with latlng
puts "creating sites"
@districts.each do |district|
  pumi = Pumi::District.find_by_id district[:code]

  if pumi
    Site.create! do |site|
      site.name = pumi.name_latin
      site.code = pumi.id
      site.status = :enable
      site.lat = district[:lat]
      site.lng = district[:lng]
    end
  end
end


# users
role_ids = Role.ids
site_ids = Site.ids
site_codes = Site.all.map(&:code)

puts "creating users"
10.times.each do |i|
  user = User.new do |u|
    u.email = FFaker::Internet.email
    u.actived = true
    u.password = FFaker::Internet.password
    u.role_id = role_ids.sample
    u.site_id = site_ids.sample
  end

  unless user.save
    puts user.inspect
  end
end

# ticket
statuses = Ticket.statuses.keys

puts "creating tickets"
10.times.each do |i|
  Ticket.create! do |t|
    site_id = site_ids.sample

    t.code = "#{site_id}#{FFaker::Code.ean[0...8]}"
    t.status = statuses.sample
    t.site_id = site_id
    t.updated_at = (0...6).to_a.sample.days.ago
  end
end

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

messages_test = [
  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      }
    ]
  },
  {
    platform_name: "Verboice",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      }
    ]
  },

  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      },
      {
        name: "owso_info",
        value: "certify_docs"
      },
      {
        name: "certify_docs",
        value: ["certify_doc_1", "certify_doc_2"].sample
      }
    ]
  },
  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      },
      {
        name: "owso_info",
        value: "main_dbs"
      },
      {
        name: "main_dbs",
        value: ["dbs_btn1", "dbs_btn2"].sample
      }
    ]
  },
  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      },
      {
        name: "owso_info",
        value: "main_construction"
      },
      {
        name: "main_construction",
        value: ["main_construction 1", "main_construction 2", "main_construction 3"].sample
      }
    ]
  },
  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      },
      {
        name: "owso_info",
        value: "main_landtitle"
      },
      {
        name: "main_dbs",
        value: ["main_landtitle 1", "main_landtitle 2", "main_landtitle 3"].sample
      }
    ]
  },
  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      },
      {
        name: "owso_info",
        value: "main_landrefill"
      },
      {
        name: "main_dbs",
        value: ["main_landrefill 1", "main_landrefill 2", "main_landrefill 3"].sample
      }
    ]
  },
  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      },
      {
        name: "feedback-intro",
        value: "feedback_level"
      },
      {
        name: "feedback_level",
        value: ["ក្រុងបាត់ដំបង", "ខេត្ត/ស្រុកផ្សេងៗ"].sample
      },
      {
        name: "feedback_challenge",
        value: ["high price", "complicated", "take long time", "not enough info", "not friendly", "lack of equipments", "other_feedback"].sample
      },
      {
        name: "feedback_q2",
        value: ["working time", "speech", "provide info", "document completion", "form price", "deliver on time"].sample
      },
      {
        name: "feedback_q3",
        value: ["working time", "speech", "provide info", "document completion", "form price", "deliver on time"].sample
      }
    ]
  },

  {
    platform_name: "Messenger",
    steps: [
      {
        name: "gender",
        value: ["f", "m"].sample
      },
      {
        name: "location_code",
        value: site_codes.sample
      },
      {
        name: "main_menu",
        value: "tracking"
      },
      {
        name: "tracking",
        value: "#{site_codes.sample}#{FFaker::Code.ean[0...8]}"
      }
    ]
  }
]

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
          variable = VoiceVariable.find_or_create_by(name: step[:name])
          variable_value = variable.values.find_or_create_by(raw_value: step[:value])
          step = message.steps.create(value: variable_value)
          step.step_value.update(created_at: (0...6).to_a.sample.days.ago)
        end
      end
    else
      messenger_user_id = FFaker::Code.ean
      content = TextMessage.find_or_create_by(messenger_user_id: messenger_user_id)
      message = Message.create_or_return(platform_name, content)

      # .take(rand(1...steps.count))
      if steps.present?
        steps.each do |step|
          variable = TextVariable.find_or_create_by(name: step[:name])
          variable_value = variable.values.find_or_create_by(raw_value: step[:value])
          step = message.steps.create(value: variable_value)
          step.step_value.update(created_at: (0...6).to_a.sample.days.ago)
        end
      end
    end
  end
end

puts "", "Done"
