module PullRequests
  # Assigns random reviewers to a pull request
  class RandomReviewerAssigner
    def initialize(pull_request, assignment_count)
      @pull_request      = pull_request
      @assignment_count  = assignment_count
    end

    def assign_reviewers(team_memberships)
      get_random_team_memberships(team_memberships).map do |team_membership|
        pull_request.review_assignments.create(team_membership: team_membership)
      end
    end

    private

    def get_random_team_memberships(team_memberships)
      team_memberships
        .only_team_mates(pull_request.author)
        .sample(assignment_count)
    end

    attr_reader :pull_request, :assignment_count
  end
end
