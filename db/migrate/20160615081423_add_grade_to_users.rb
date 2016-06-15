class AddGradeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :overall_grade, :string
    add_column :users, :evaluation_rate, :string
  end
end
