class AddHitCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hit_count, :integer, default: 0
  end
end
