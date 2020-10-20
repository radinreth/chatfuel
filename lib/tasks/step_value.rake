namespace :step_value do
  desc "Migrate gender from step values to message"
  task migrate_gender: :environment do
    gender_variable = Variable.gender

    gender_variable.step_values.find_each do |step|
      factory = GenderFactory.new
      gender = factory.for(step.variable_variable.raw_value)
      message.update(gender: gender.get)
    end
  end

end
