# == Schema Information
#
# Table name: evaluation_results
#
#  id              :integer          not null, primary key
#  evaluation_rate :string
#  grade_math      :integer
#  grade_romana    :integer
#  grade_native    :integer
#  school          :string
#  county_id       :integer
#  year            :integer
#  position        :integer
#

class EvaluationResult < ActiveRecord::Base

  belongs_to :county

  def self.import_data(row)
    create(evaluation_rate: row['EvaluationRate'],
           grade_math: row['GradeMath'],
           grade_romana: row['GradeRomana'],
           grade_native: row['GradeNative'],
           county: row['County'],
           school: row['School'])
  end


  def float_evaluation_rate
    self.evaluation_rate.to_f
  end

  def float_grade_math
    self.grade_math.to_f
  end

  def float_grade_romana
    self.grade_romana.to_f
  end

  def float_grade_native
    self.grade_native.to_f
  end
end
