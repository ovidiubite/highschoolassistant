class HighschoolDetail < ActiveRecord::Base
  belongs_to :highschool
  has_one :section
end
