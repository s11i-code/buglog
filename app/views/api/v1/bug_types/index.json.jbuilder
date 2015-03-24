json.array!(@bug_types) do |bug_type|
  json.extract! bug_type, :name, :description, :public, :created_at
  json.created_at(I18n.l(bug_type.created_at.to_date, format: :short))
  json.number_of_occurrences(bug_type.number_of_occurrences_for(@user))
  json.url api_v1_bug_type_url(bug_type, format: :json)
end
