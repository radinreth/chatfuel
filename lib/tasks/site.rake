# frozen_string_literal: true

namespace :site do
  desc 'migrate province_id'
  task migrate_province: :environment do
    Site.find_each do |site|
      site.update(province_id: site.code[0..1])
    end
  end
end
