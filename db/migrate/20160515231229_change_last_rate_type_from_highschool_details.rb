class ChangeLastRateTypeFromHighschoolDetails < ActiveRecord::Migration
  def up
    change_column :highschool_details, :last_rate, :string
  end

  def down
    change_column :highschool_details, :last_rate, :integer
  end
end
