class Project < ActiveRecord::Base
  has_many :discussions
  has_many :comments
  has_many :assignments, dependent: :destroy
  has_many :tasks

  belongs_to :user

  def liked_by? user
    users.include? user
  end

  def liked_by user
    users << user
    self.like_counter += 1
    save
  end

  def unliked_by user
    users.delete(user)
  end

  def owned_by? user
    users.include? user
  end

end
