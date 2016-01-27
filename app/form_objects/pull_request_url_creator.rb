# Creates a PR from author, title and URL. Determines repo from URL
# and assigns two random reviewers
class PullRequestUrlCreator
  MAX_REVIEW_ASSIGNMENTS = 2

  MissingRepo = Class.new(ReviewRandomizerError)

  def initialize(attributes)
    @author  = attributes[:author]
    @url     = attributes[:url]
    @title   = attributes[:title]
  end

  def create
    PullRequest.create(
      title: title,
      number: url.split('/').last.to_i,
      repo: repo,
      author: author
    ).tap do |pull_request|
      assign_reviewers(pull_request)
    end
  end

  private

  def repo
    @repo ||= author.teams.flat_map(&:repos).detect do |repo|
      url.starts_with?(repo.url)
    end
    @repo || fail(MissingRepo, missing_repo_error_message)
  end

  def team
    @team ||= repo.teams.detect do |team|
      team.users.include?(author)
    end
  end

  # TODO: Move this into separate object
  def assign_reviewers(pull_request)
    team_memberships.sample(MAX_REVIEW_ASSIGNMENTS).each do |team_membership|
      pull_request.review_assignments.create(team_membership: team_membership)
    end
  end

  def team_memberships
    team.team_memberships.where.not(user_id: author.id)
  end

  def missing_repo_error_message
    "Could not find repo with URL: #{url.split('/pull_requests').first}"
  end

  attr_reader :author, :url, :title
end
