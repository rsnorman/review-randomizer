json.pull_request do
  json.id @pull_request.id
  json.title @pull_request.title
  json.number @pull_request.number
  json.created_at @pull_request.created_at.iso8601
  json.updated_at @pull_request.updated_at.iso8601
  json.review_assignments @pull_request.review_assignments.map(&:handle)

  json.actions do
    json.show(
      full_path(repo_pull_request_path(@pull_request.repo, @pull_request))
    )
  end
end
