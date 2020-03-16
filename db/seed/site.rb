module Seed
  class Site
    def self.generate!(path = "db/seed/assets/site.csv")
      SiteService.import(path)
    end
  end
end
