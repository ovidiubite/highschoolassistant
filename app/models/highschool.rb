class Highschool < ActiveRecord::Base
  belongs_to :county
  has_many :highschool_details
end
