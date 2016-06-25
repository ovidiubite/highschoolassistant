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

require 'test_helper'

class HighschoolDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
