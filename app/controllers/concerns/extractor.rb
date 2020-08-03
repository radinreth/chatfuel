class Extractor
  def initialize(hash)
    @hash = hash.with_indifferent_access
  end

  def act
    @hash["project_variable_name"] || @hash["act"]
  end

  def value
    @hash["key"] || @hash["value"]
  end

  def set_dictionary
    Variable.find_or_create_by(name: act)
  end

  private
    attr_reader :hash
end
