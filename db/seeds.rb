# frozen_string_literal: true
paths = Rails.root.join('db', 'seed', '**', '*.rb')
Dir[paths].each { |f| require f }

%w[Variable Ticket Site Message Step Track].each do |model|
  model.constantize.send(:destroy_all)
  "Seed::#{model}".constantize.send(:generate!)
end
