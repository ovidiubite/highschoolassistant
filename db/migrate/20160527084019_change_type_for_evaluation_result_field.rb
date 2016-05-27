class ChangeTypeForEvaluationResultField < ActiveRecord::Migration
  def up
    change_column :evaluation_results, :evaluation_rate, :string
  end

  def down
    change_column :evaluation_results, :evaluation_rate, :integer
  end
end
