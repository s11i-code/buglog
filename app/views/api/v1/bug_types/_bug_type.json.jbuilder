json.extract! bug_type, :id, :name, :description, :created_at, :updated_at
json.owned_by_current_user(bug_type.creator == current_user)
json.vote_id_by_current_user(bug_type.vote_id_by_user current_user)
json.vote_count(bug_type.votes.count)
