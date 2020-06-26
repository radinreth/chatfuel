require "csv"

module Seed
  class User
    def self.generate!
      CSV.foreach("db/seed/assets/users.csv", headers: true) do |row|
        user = ::User.create(email: row['email'], role_id: ::Role.find_by(name: row['role']).id, password: '123456')
        user.confirm
      end
    end
  end
end
