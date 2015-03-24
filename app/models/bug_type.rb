class BugType < ActiveRecord::Base

  has_many :bug_occurrences, dependent: :destroy

  belongs_to :creator, class_name: 'User'

  def self.find_all_for(user)
    BugType.where("creator_id = ? OR public = ?", user.id, true)
  end

  def number_of_occurrences_for(user)
    self.bug_occurrences.where(user_id: user.id).count
  end
end
