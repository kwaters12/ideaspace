class AddUsersToDiscussions < ActiveRecord::Migration
  def change
    add_reference :discussions, :user, index: true
  end
end
