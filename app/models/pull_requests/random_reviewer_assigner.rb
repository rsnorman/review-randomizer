module PullRequests
  # Assigns random reviewers to a pull request
  class RandomReviewerAssigner
    def initialize(pull_request, team)
      @pull_request  = pull_request
      @team          = team
    end

    def assign_reviewers(assignment_count)
      get_random_team_memberships(assignment_count).map do |team_membership|
        create_review_assignment(team_membership)
      end
    end

    private

    def get_random_team_memberships(assignment_count)
      author_team_mates.sample(assignment_count)
    end

    def author
      pull_request.author
    end

    def author_team_mates
      team.team_mates_for(author)
    end

    def create_review_assignment(team_membership)
      pull_request.review_assignments.create(team_membership: team_membership)
    end

    attr_reader :pull_request, :team
  end
end
