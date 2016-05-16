# == Schema Information
#
# Table name: highschools
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  county_id  :integer
#

require 'test_helper'

class HighschoolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
