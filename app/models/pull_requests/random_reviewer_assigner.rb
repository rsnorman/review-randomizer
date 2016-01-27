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
      allowed_team_memberships(team_memberships).sample(assignment_count)
    end

    def allowed_team_memberships(team_memberships)
      team_memberships.where.not(user_id: pull_request.author_id)
    end

    attr_reader :pull_request, :assignment_count
  end
end
