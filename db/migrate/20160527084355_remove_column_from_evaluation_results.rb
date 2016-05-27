class RemoveColumnFromEvaluationResults < ActiveRecord::Migration
  def change
    remove_column :evaluation_results, :county, :string
    add_reference :evaluation_results, :county, index: true, foreign_key: true
  end
end
