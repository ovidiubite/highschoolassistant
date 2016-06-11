class ChangeFieldsForAdmissionResult < ActiveRecord::Migration
  def up
    change_column :admission_results, :admission_rate, :string
    change_column :admission_results, :evaluation_rate, :string
    change_column :admission_results, :graduation_rate, :string
    change_column :admission_results, :grade_math, :string
    change_column :admission_results, :grade_romana, :string
    change_column :admission_results, :grade_native, :string
  end

  def down
    change_column :admission_results, :admission_rate, :integer
    change_column :admission_results, :evaluation_rate, :integer
    change_column :admission_results, :graduation_rate, :integer
    change_column :admission_results, :grade_math, :integer
    change_column :admission_results, :grade_romana, :integer
    change_column :admission_results, :grade_native, :integer
  end
end
