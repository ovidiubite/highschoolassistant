class AddFiledToEvaluationResults < ActiveRecord::Migration
  def change
    add_column :evaluation_results, :year, :integer
  end
end
