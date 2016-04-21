class CreateHighschoolDetails < ActiveRecord::Migration
  def change
    create_table :highschool_details do |t|
      t.integer :students_number
      t.integer :last_rate
      t.integer :year

      t.timestamps null: false
    end
  end
end
