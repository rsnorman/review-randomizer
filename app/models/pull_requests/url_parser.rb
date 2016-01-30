module PullRequests
  # Parses the pull request attributes from a URL
  class UrlParser
    URL_PATH_DELIMITER       = '/'.freeze
    GITHUB_PR_RESOURCE_PATH  = '/pull'.freeze

    MissingRepo = Class.new(ReviewRandomizerError)

    def initialize(url, repos = Repo.all)
      @url    = url
      @repos  = repos
    end

    def as_json
      {
        number:   parse_number,
        repo:     find_repo
      }
    end

    private

    def parse_number
      url.split(URL_PATH_DELIMITER).last.to_i
    end

    def parse_repo_url
      url.split(GITHUB_PR_RESOURCE_PATH).first
    end

    def find_repo
      repos.find_by(url: parse_repo_url).tap do |repo|
        fail(MissingRepo, missing_repo_error_message) if repo.nil?
      end
    end

    def missing_repo_error_message
      "Could not find repo with URL: #{parse_repo_url}"
    end

    attr_reader :url, :repos
  end
end
