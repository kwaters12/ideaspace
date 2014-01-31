class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string      :name
      t.date        :due_date
      t.boolean     :completed, default: false
      t.references  :project, index: true


      t.timestamps
    end
  end
end
