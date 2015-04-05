class BugType < ActiveRecord::Base

  belongs_to :creator, class_name: 'User'
  has_many :votes, dependent: :destroy
end
