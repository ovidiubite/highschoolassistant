# == Schema Information
#
# Table name: highschool_details
#
#  id              :integer          not null, primary key
#  students_number :integer
#  last_rate       :string
#  year            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_id      :integer
#  highschool_id   :integer
#  first_rate      :string
#

class HighschoolDetail < ActiveRecord::Base
  belongs_to :highschool
  belongs_to :section
  has_many :results
  has_many :admission_results

  def float_last_rate
    self.last_rate.to_f
  end
end
