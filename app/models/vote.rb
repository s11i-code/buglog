class Vote < ActiveRecord::Base

  belongs_to :bug_type

  belongs_to :user

end
