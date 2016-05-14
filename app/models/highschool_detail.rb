class HighschoolDetail < ActiveRecord::Base
  belongs_to :highschool
  belongs_to :section
end
