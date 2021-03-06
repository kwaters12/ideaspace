class Task < ActiveRecord::Base
  belongs_to :project
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

end
