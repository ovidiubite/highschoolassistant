class CreateEvaluationResults < ActiveRecord::Migration
  def change
    create_table :evaluation_results do |t|
      t.string :county
      t.integer :evaluation_rate
      t.integer :grade_math
      t.integer :grade_romana
      t.integer :grade_native
      t.string :school
    end
  end
end
