class Task < ActiveRecord::Base
  belongs_to :project
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  scope :completed_tasks,   -> { where(completed: true) }
  scope :upcoming_tasks, -> { where(completed: false) }

end
