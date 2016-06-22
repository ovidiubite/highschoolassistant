class ChangeFieldsFromAdmissionResults < ActiveRecord::Migration
  def change
    remove_column :admission_results, :county, :string
    remove_column :admission_results, :section, :string
    add_column :admission_results, :year, :integer

    add_reference :admission_results, :county, index: true, foreign_key: true
    add_reference :admission_results, :section, index: true, foreign_key: true
    add_reference :admission_results, :highschool_detail, index: true, foreign_key: true
  end
end
