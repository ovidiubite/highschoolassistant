# == Schema Information
#
# Table name: results
#
#  id                    :integer          not null, primary key
#  percentage            :string
#  overall_grade         :string
#  evaluation_rate       :string
#  graduation_rate       :string
#  date                  :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  highschool_details_id :integer
#  user_id               :integer
#

class Result < ActiveRecord::Base

  belongs_to :user
  belongs_to :highschool_detail

  def float_evaluation_rate
    self.evaluation_rate.to_f
  end

  def float_graduation_rate
    self.graduation_rate.to_f
  end

  def float_overall_grade
    self.overall_grade.to_f
  end

  def float_percentage
    self.percentage.to_f
  end

  def self.calculate_percentage
    
  end
end
