# == Schema Information
#
# Table name: counties
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alias      :string
#

class County < ActiveRecord::Base
  has_many :highschools
  has_many :evaluation_results
end
