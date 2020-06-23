require "oj"

class JsonParser
  attr_reader :hash

  def initialize(hash)
    @hash = hash
  end

  def to_json
    parse!
    Oj.load(hash)
  end

  private

  def parse!
    hash.gsub!("=>", ":")
  end
end
