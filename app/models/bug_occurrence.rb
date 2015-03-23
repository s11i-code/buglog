class BugOccurrence < ActiveRecord::Base
  belongs_to :user
  belongs_to :bug_type
end
