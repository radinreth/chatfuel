class DefaultVariable
  attr_reader :name, :value

  def initialize(name, value)
    @name = name
    @value = value
  end

  def audio_path
  end

  alias_method :text, :value
end

class AudioVariable
  def initialize(voice, value)
    @voice = voice
    @value = value
  end

  def audio_path
    "http://verboice.com/projects/#{@voice.project_id}/calls/#{@voice.CallSid}/results/#{@value}"
  end
end

class VoiceVariable < Variable
  def self.transform(name, value)
    find_by(name: name, value: value) || DefaultVariable.new(name, value)
  end 
end
