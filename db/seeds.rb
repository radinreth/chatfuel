# frozen_string_literal: true
Dir[Rails.root.join('db', 'seed', '**', '*.rb')].each { |f| require f }

Seed::Variable.generate!
Seed::Ticket.generate!
Seed::Site.generate!
Seed::Message.generate!
Seed::Step.generate!
Seed::Track.generate!
