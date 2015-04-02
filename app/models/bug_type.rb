class BugType < ActiveRecord::Base

  belongs_to :creator, class_name: 'User'

  def self.find_all_for(user)
    BugType.where("creator_id = ?", user.id)
  end

end
