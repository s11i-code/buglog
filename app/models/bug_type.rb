class BugType < ActiveRecord::Base

  belongs_to :creator, class_name: 'User'

  has_many :votes, dependent: :destroy

  validates :name, presence: true

  validates :creator, presence: true

  def vote_id_by_user(user)
    self.votes.where(user_id: user.id).pluck(:id).first if user
  end

  def voted_by?(user)
    !vote_id_by_user(user).nil?
  end

end
