module PullRequests
  # Creates a PR from author, title and URL. Determines repo from URL
  # and assigns two random reviewers
  class PullRequestCreator
    DEFAULT_REVIEW_ASSIGNMENTS = 2

    def initialize(attrs)
      fail ArgumentError, 'Missing :url attribute'    unless attrs.key?(:url)
      fail ArgumentError, 'Missing :author attribute' unless attrs.key?(:author)

      @attributes = attrs.merge(url_as_json(attrs.delete(:url)))
    end

    def create
      PullRequest.transaction do
        create_pull_request.tap do |pull_request|
          assign_reviewers(pull_request)
        end
      end
    end

    private

    def url_as_json(url)
      PullRequests::UrlParser.new(url).as_json
    end

    def create_pull_request
      PullRequest.create(attributes)
    end

    def assign_reviewers(pull_request)
      PullRequests::RandomReviewerAssigner.new(pull_request, team)
        .assign_reviewers(DEFAULT_REVIEW_ASSIGNMENTS)
    end

    def team
      @team ||= team_finder.for_user!(attributes[:author])
    end

    def team_finder
      Repos::TeamFinder.new(attributes[:repo])
    end

    attr_reader :attributes
  end
end
