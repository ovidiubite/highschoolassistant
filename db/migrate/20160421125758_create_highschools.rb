class CreateHighschools < ActiveRecord::Migration
  def change
    create_table :highschools do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
