include ApplicationHelper
Role.delete_all
User.delete_all
County.delete_all
Highschool.delete_all
HighschoolDetail.delete_all
Section.delete_all
Result.delete_all
EvaluationResult.delete_all

Role.create!(name: 'user')

User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', role_id: Role.create!(name: 'admin').id)

ApplicationHelper::HASH_COUNTIES.each do |key, value|
  County.create!(name: value, alias: key.to_s )
end
