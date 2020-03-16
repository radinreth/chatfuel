class TimeParser
  class << self
    def parse(hash)
      parsed = convert(hash)
      yield(parsed) if block_given?
    end

    private

    def convert(hash)
      hash.keys.each do |key|
        hash[key] = evaluate(hash.delete(key)) unless hash[key].nil?
      end
      hash
    end

    def evaluate(value)
      return value unless value =~ %r{\d+\/\d+\/\d+}

      date = Date.strptime(value, '%m/%d/%y')
      date.iso8601
    end
  end
end
