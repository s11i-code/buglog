class MakeIndexUniqueInVotes < ActiveRecord::Migration
  def up
    remove_index :votes, name: "index_votes_on_user_id_and_bug_type_id"
    add_index :votes, [:user_id, :bug_type_id], unique: true
  end
end
