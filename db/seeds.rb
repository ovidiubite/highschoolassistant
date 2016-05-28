include ApplicationHelper
include "../lib/active_record/add_reset_pk_sequence_to_base.rb"
Role.delete_all
User.delete_all
County.delete_all
Highschool.delete_all
HighschoolDetail.delete_all
Section.delete_all
Result.delete_all
EvaluationResult.delete_all

Role.reset_pk_sequence
User.reset_pk_sequence
County.reset_pk_sequence
Highschool.reset_pk_sequence
HighschoolDetail.reset_pk_sequence
Section.reset_pk_sequence
Result.reset_pk_sequence
EvaluationResult.reset_pk_sequence

Role.create!(name: 'user')

User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password', role_id: Role.find_or_create_by(name: 'admin').id)

ApplicationHelper::HASH_COUNTIES.each do |key, value|
  County.create!(name: value, alias: key.to_s )
end
