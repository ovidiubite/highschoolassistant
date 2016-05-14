class AddHighSchoolRefToHighschoolDetail < ActiveRecord::Migration
  def change
    add_reference :highschool_details, :highschool, index: true, foreign_key: true
  end
end
