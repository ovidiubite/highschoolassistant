class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :percentage
      t.string :overall_grade
      t.string :evaluation_rate
      t.string :graduation_rate
      t.date :date

      t.timestamps null: false
    end

    add_reference :results, :highschool_details, index: true, foreign_key: true
    add_reference :results, :user, index: true, foreign_key: true
  end
end
