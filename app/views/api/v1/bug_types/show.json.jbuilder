json.extract! @bug_type, :id, :name, :description, :created_at, :updated_at
json.owned_by_current_user(@bug_type.creator == current_user)
