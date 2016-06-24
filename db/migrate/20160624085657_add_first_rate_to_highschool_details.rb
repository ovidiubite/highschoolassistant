class AddFirstRateToHighschoolDetails < ActiveRecord::Migration
  def change
    add_column :highschool_details, :first_rate, :string
  end
end
