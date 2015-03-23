class BugType < ActiveRecord::Base

  has_many :bug_occurrences, dependent: :destroy

end
