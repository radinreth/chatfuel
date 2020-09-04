namespace :message do
  desc "Update message district_id when location variable change"

  task migrate_district_id: :environment do
    location_variable = Variable.find_by(is_location: true)

    return if location_variable.nil?

    ActiveRecord::Base.transaction do
      StepValue.where(variable: location_variable).find_each do |s|
        s.touch if s.message && s.message.district_id
      end
    end
  end
end
