require "csv"

module Seed
  class Role
    def self.generate!
      CSV.foreach("db/seed/assets/roles.csv", headers: true) do |row|
        ::Role.create(name: row['name'])
      end
    end
  end
end
