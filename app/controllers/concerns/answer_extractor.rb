class AnswerExtractor < Extractor
  def initialize(hash)
    super(hash)
  end

  def text
    variable.try(:text) || value
  end

  private

  def variable
    @variable ||= Variable.find_by(name: act, value: value)
  end
end