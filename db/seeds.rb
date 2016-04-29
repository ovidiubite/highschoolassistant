Role.create!(name: 'admin')
Role.create!(name: 'user')

User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role_id: Role.first.id)
