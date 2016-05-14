class AddCountyRefToHighschool < ActiveRecord::Migration
  def change
    add_reference :highschools, :county, index: true, foreign_key: true
  end
end
