json.array!(@repos) do |repo|
  json.extract! repo, :id, :company, :organization, :name, :description, :url
  json.url repo_url(repo, format: :json)
end
