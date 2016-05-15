include ApplicationHelper
Role.delete_all
User.delete_all
County.delete_all
Highschool.delete_all
HighschoolDetail.delete_all

Role.create!(name: 'admin')
Role.create!(name: 'user')

User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', role_id: Role.where(name: 'admin').first.id)

ApplicationHelper::HASH_COUNTIES.each do |key, value|
  County.create!(name: value, alias: key.to_s )
end
