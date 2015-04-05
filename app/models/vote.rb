class Vote < ActiveRecord::Base
  belongs_to :bug_type
end
