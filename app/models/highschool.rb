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

class Highschool < ActiveRecord::Base
  belongs_to :county
  has_many :highschool_details
end
