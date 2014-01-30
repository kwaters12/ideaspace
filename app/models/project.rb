class Project < ActiveRecord::Base
  has_many :discussions
  has_many :comments
end
