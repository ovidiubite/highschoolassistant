class AddPositionToAdmissionResults < ActiveRecord::Migration
  def change
    add_column :admission_results, :position, :integer
  end
end
