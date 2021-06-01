class SessionService
  attr_reader :session, :value

  def initialize(session)
    @session = session
  end

  def self.create(platform_name, session_id, source_id = nil, &block)
    Session.transaction do
      yield session(platform_name, session_id, source_id)
    end
  end

  def append_steps
    step_value = session.step_values.find_or_initialize_by(variable: value.variable)
    step_value.update!(variable_value: value)
  end

  def add_value(name, value)
    variable = Variable.find_or_create_by(name: name)
    @value = variable.values.find_or_create_by(raw_value: value)
    self
  end

  private

    def self.session(platform_name, session_id, source_id)
      session = Session.create_from_type(platform_name, session_id, source_id)
      new(session)
    end
end
