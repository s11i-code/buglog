json.array!(@bug_types) do |bug_type|
  json.extract! bug_type, :id, :name, :description, :public
  json.url api_v1_bug_type_url(bug_type, format: :json)
end
