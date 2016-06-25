class AddColumnToEvaluationResult < ActiveRecord::Migration
  def change
    add_column :evaluation_results, :position, :integer
  end
end
