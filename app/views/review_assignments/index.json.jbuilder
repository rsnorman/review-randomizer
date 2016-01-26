json.array!(@review_assignments) do |review_assignment|
  json.extract! review_assignment, :id, :pull_request_id, :team_membership_id
  json.url review_assignment_url(review_assignment, format: :json)
end
