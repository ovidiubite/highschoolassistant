# == Schema Information
#
# Table name: admission_results
#
#  id              :integer          not null, primary key
#  admission_rate  :integer
#  evaluation_rate :integer
#  graduation_rate :integer
#  grade_math      :integer
#  grade_romana    :integer
#  grade_native    :integer
#  assigned_school :string
#  section         :string
#  county          :string
#

class AdmissionResult < ActiveRecord::Base

  def self.import_data(row)
    create!(admission_rate: row['AdmissionRate'],
            evaluation_rate: row['EvaluationRate'],
            graduation_rate: row['GraduationRate'],
            grade_math: row['GradeMath'],
            grade_romana: row['GradeRomana'],
            grade_native: row['GradeNative'],
            assigned_school: row['AssignedSchool'],
            section: row['Section'],
            county: row['County'])
  end
end
