json.array!(@bug_types) do |bug_type|
  json.partial! 'bug_type', bug_type: bug_type
end
