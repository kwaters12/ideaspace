class Discussion < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  has_many :comments

  def owned_by? user
    users.include? user
  end

end
