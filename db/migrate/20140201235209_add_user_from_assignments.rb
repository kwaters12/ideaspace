class AddUserFromAssignments < ActiveRecord::Migration
  def change
    add_reference :assignments, :user, index: true
  end
end
