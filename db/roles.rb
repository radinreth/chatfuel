# roles
roles = [
  {
    name: "system_admin",
    variables: ["owso_info", "tracking"]
  },
  {
    name: "site_admin",
    variables: ["owso_info"]
  },
  {
    name: "site_ombudsman",
    variables: ["feedback-intro"]
  }
]

puts "creating roles"
roles.each do |role_params|
  variables = role_params.delete(:variables)
  role = Role.find_or_initialize_by(role_params)

  role.variables = variables.map do |variable_name|
    Variable.find_by name: variable_name
  end.compact
  role.save
end
