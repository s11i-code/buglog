json.array!(@bug_types) do |bug_type|
  json.extract! bug_type, :id, :name, :description, :public, :created_at
  json.created_at(I18n.l(bug_type.created_at.to_date, format: :short))
  json.url api_v1_bug_type_url(bug_type, format: :json)
end
