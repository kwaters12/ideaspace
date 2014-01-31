class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :project, index: true
      t.references :task, index: true

      t.timestamps
    end
  end
end
