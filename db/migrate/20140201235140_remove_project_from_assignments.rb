class RemoveProjectFromAssignments < ActiveRecord::Migration
  def change
    remove_reference :assignments, :project, index: true
  end
end
