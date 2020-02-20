class AudioExtractor < Extractor
  def initialize(voice, hash)
    @voice = voice
    super(hash)
  end

  def audio_path
    host = 'http://verboice.com/projects'
    path = [@voice.project_id, 'calls', @voice.callsid, 'results', value]
    "#{host}/#{path.join('/')}"
  end
end