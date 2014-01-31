class Project < ActiveRecord::Base
  has_many :discussions
  has_many :comments
  has_many :assignments, dependent: :destroy
  has_many :tasks
end
