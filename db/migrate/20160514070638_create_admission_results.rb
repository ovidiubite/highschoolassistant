class CreateAdmissionResults < ActiveRecord::Migration
  def change
    create_table :admission_results do |t|
      t.integer :admission_rate
      t.integer :evaluation_rate
      t.integer :graduation_rate
      t.integer :grade_math
      t.integer :grade_romana
      t.integer :grade_native
      t.string :assigned_school
      t.string :section
      t.string :county
    end
  end
end
