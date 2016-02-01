module Repos
  # Finds teams tied to repos based on a user's team memberships
  class TeamFinder
    RepoTeamConflict = Class.new(ReviewRandomizerError)
    RepoTeamMismatch = Class.new(ReviewRandomizerError)

    def initialize(repo)
      @repo = repo
    end

    def for_team_member!(user)
      for_team_member(user).tap do |team|
        fail(
          RepoTeamMismatch,
          'User not on team tied to pull request\'s repo'
        ) if team.nil?
      end
    end

    def for_team_member(user)
      teams_for_team_member(user).tap do |teams|
        if teams.size > 1
          fail RepoTeamConflict, 'Multiple teams exist for the repo'
        end
      end.first
    end

    private

    def teams_for_team_member(user)
      repo.teams.select do |team|
        team.users.where(id: user.id).exists? ||
          team.team_memberships.where(id: user.id).exists?
      end
    end

    attr_reader :repo
  end
end
