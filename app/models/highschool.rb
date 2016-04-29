class Highschool < ActiveRecord::Base
  has_one :county
  has_many :highschool_details
end
