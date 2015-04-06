class BugType < ActiveRecord::Base

  belongs_to :creator, class_name: 'User'

  has_many :votes, dependent: :destroy

  def voted_by?(user)
    self.votes.where(user_id: user.id).exists?
  end
end
