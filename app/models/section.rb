class Section < ActiveRecord::Base
  has_many :highschool_detail
  validates_presence_of :name, uniqueness: true
end
