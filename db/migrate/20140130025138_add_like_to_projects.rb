class AddLikeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :like_count, :integer, default: 0
  end
end
