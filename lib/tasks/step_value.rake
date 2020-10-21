namespace :step_value do
  desc "Migrate gender from step values to message"
  task migrate_gender_raw_value_to_message: :environment do
    gender_variable = Variable.gender

    if gender_variable.present?
      ActiveRecord::Base.transaction do
        gender_variable.step_values.find_each do |step|
          gender = Gender.get(step.variable_value.raw_value)
          step.message.update!(gender: gender.name)
          step.session.update!(gender: gender.name)
        end
      end
    end
  end
end
