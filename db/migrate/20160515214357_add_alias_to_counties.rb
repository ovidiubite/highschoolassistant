class AddAliasToCounties < ActiveRecord::Migration
  def change
    add_column :counties, :alias, :string
  end
end
