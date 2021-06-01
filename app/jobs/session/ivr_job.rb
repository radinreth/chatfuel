class Session::IvrJob < ApplicationJob
  def perform(name, value, session_id, source_id)
    SessionService.create('Verboice', session_id, source_id) do |session|
      session.add_value(name, value).append_steps
    end
  end
end
