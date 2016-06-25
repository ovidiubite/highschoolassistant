# == Schema Information
#
# Table name: admission_results
#
#  id                   :integer          not null, primary key
#  admission_rate       :string
#  evaluation_rate      :string
#  graduation_rate      :string
#  grade_math           :string
#  grade_romana         :string
#  grade_native         :string
#  assigned_school      :string
#  year                 :integer
#  county_id            :integer
#  section_id           :integer
#  highschool_detail_id :integer
#  position             :integer
#

class AdmissionResult < ActiveRecord::Base

  belongs_to :county
  belongs_to :section
  belongs_to :highschool_detail

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

  def float_evaluation_rate
    self.evaluation_rate.to_f
  end

  def float_graduation_rate
    self.graduation_rate.to_f
  end

  def float_admission_rate
    self.overall_grade.to_f
  end
end
