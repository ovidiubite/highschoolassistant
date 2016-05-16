class RenameCityToCountyInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :city, :string
    add_reference :users, :county, index: true, foreign_key: true
  end
end
