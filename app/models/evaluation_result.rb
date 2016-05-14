class EvaluationResult < ActiveRecord::Base

  def self.import_data(row)
    create(evaluation_rate: row['EvaluationRate'],
           grade_math: row['GradeMath'],
           grade_romana: row['GradeRomana'],
           grade_native: row['GradeNative'],
           county: row['County'],
           school: row['School'])
  end
end
