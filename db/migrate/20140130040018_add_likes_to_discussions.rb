class AddLikesToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :like_count, :integer, default: 0
  end
end
