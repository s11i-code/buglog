class AddUniqueIndexInVotes < ActiveRecord::Migration
  def change
    add_index :votes, [:user_id, :bug_type_id]
  end
end
