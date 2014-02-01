class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  has_many :projects
  has_many :discussions
  has_many :comments
  has_many :assignments, dependent: :destroy
  has_many :tasks, through: :assignments

  def name_display
    if first_name || last_name
      "#{first_name} #{last_name}".strip
    else
      email
    end
  end

  def like_for project
    likes.where(project_id: project.id).first
  end

  def has_liked? project
    liked_projects.include? project
  end
end
