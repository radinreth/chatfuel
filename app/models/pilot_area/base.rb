module PilotArea
  class Base
    def self.all(codes)
      codes.to_s.split(',')
    end
  end
end
