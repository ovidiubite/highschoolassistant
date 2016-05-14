class AddSectionRefToHighschoolDetail < ActiveRecord::Migration
  def change
    add_reference :highschool_details, :section, index: true, foreign_key: true
  end
end
