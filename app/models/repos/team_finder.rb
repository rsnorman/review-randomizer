module Repos
  # Finds teams tied to repos based on a user's team memberships
  class TeamFinder
    RepoTeamConflict = Class.new(ReviewRandomizerError)
    RepoTeamMismatch = Class.new(ReviewRandomizerError)

    def initialize(repo)
      @repo = repo
    end

    def for_user!(user)
      for_user(user).tap do |team|
        fail(
          RepoTeamMismatch,
          'User not on team tied to pull request\'s repo'
        ) if team.nil?
      end
    end

    def for_user(user)
      repo.teams.select { |team| team.users.include?(user) }.tap do |teams|
        if teams.size > 1
          fail RepoTeamConflict, 'Multiple teams exist for the repo'
        end
      end.first
    end

    private

    attr_reader :repo
  end
end
