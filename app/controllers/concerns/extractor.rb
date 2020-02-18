class Extractor
  def initialize(hash)
    @hash = hash
  end

  def act
    @hash['project_variable_name']
  end

  def value
    @hash['key'] || @hash['value']
  end

  private

  attr_reader :hash
end
