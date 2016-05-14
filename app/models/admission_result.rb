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
