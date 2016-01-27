module PullRequests
  # Creates a PR from author, title and URL. Determines repo from URL
  # and assigns two random reviewers
  class PullRequestCreator
    DEFAULT_REVIEW_ASSIGNMENTS = 2

    TeamRepoMismatch = Class.new(ReviewRandomizerError)

    def initialize(attrs)
      fail ArgumentError, 'Missing :url attribute'    unless attrs.key?(:url)
      fail ArgumentError, 'Missing :author attribute' unless attrs.key?(:author)

      @attributes = attrs.merge(
        PullRequests::UrlParser.new(attrs.delete(:url)).as_json
      )
    end

    def create
      PullRequest.transaction do
        PullRequest.create(attributes).tap do |pull_request|
          PullRequests::RandomReviewerAssigner.new(
            pull_request, DEFAULT_REVIEW_ASSIGNMENTS
          ).assign_reviewers(team_memberships)
        end
      end
    end

    private

    def team_memberships
      team.team_memberships
    end

    def team
      @team ||= attributes[:repo].teams.detect do |team|
        team.users.include?(attributes[:author])
      end

      if @team.nil?
        fail TeamRepoMismatch, 'Author not on team tied to pull request\'s repo'
      end

      @team
    end

    attr_reader :attributes
  end
end
